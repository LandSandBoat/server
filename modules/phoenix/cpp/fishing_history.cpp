/************************************************************************
 * Fishing History
 *
 * Records every fish or item an angler lands into char_fishing_history
 * and exposes the most recent catches to Lua for GM commands. Needs the
 * fishing patch applied, which adds the observer slot.
 *
 * Also keeps lifetime records in char_fishing_records: lines cast, and the
 * longest and heaviest big fish landed.
 *
 * Lua:
 * - GetFishingHistory(charName, limit) - newest first, limit is clamped to 1-50
 * - GetFishingRecords(charName)        - lifetime records, zeros if the angler has none
 ************************************************************************/

#include "common/database.h"
#include "common/earth_time.h"
#include "common/lua.h"
#include "map/entities/char_entity.h"
#include "map/utils/fishingutils.h"
#include "map/utils/moduleutils.h"

namespace
{

constexpr auto retentionSeconds = uint32{ 30 * 24 * 60 * 60 };

void onCast(const CCharEntity* PChar)
{
    db::preparedStmt("INSERT INTO char_fishing_records (charid, lines_cast) VALUES (?, 1) "
                     "ON DUPLICATE KEY UPDATE lines_cast = lines_cast + 1",
                     PChar->id);
}

void onLanded(const CCharEntity* PChar)
{
    const auto& hooked = *PChar->hookedFish;

    db::preparedStmt("INSERT INTO char_fishing_history (charid, itemid, count, zoneid, caught_at) VALUES (?, ?, ?, ?, ?)",
                     PChar->id,
                     static_cast<uint16>(hooked.catchid),
                     hooked.count,
                     static_cast<uint16>(PChar->getZone()),
                     earth_time::timestamp());

    // Mirrors CatchFish, which only stamps a size onto big fish
    if (hooked.catchtype != FISHINGCATCHTYPE_BIGFISH || hooked.length <= 1 || hooked.weight <= 1)
    {
        return;
    }

    // Assignments run left to right, so each item id is compared against the record before it is raised
    db::preparedStmt("INSERT INTO char_fishing_records (charid, longest_ilms, longest_itemid, heaviest_ponzes, heaviest_itemid) VALUES (?, ?, ?, ?, ?) "
                     "ON DUPLICATE KEY UPDATE "
                     "longest_itemid = IF(VALUES(longest_ilms) > longest_ilms, VALUES(longest_itemid), longest_itemid), "
                     "longest_ilms = GREATEST(longest_ilms, VALUES(longest_ilms)), "
                     "heaviest_itemid = IF(VALUES(heaviest_ponzes) > heaviest_ponzes, VALUES(heaviest_itemid), heaviest_itemid), "
                     "heaviest_ponzes = GREATEST(heaviest_ponzes, VALUES(heaviest_ponzes))",
                     PChar->id,
                     hooked.length,
                     static_cast<uint16>(hooked.catchid),
                     hooked.weight,
                     static_cast<uint16>(hooked.catchid));
}

void observe(const CCharEntity* PChar, const fishingutils::FishingEvent event, const uint32 /* para */)
{
    if (event == fishingutils::FishingEvent::Cast)
    {
        onCast(PChar);
        return;
    }

    if (event == fishingutils::FishingEvent::Landed && PChar->hookedFish != nullptr)
    {
        onLanded(PChar);
    }
}

auto getFishingHistory(const std::string& charName, const uint32 limit) -> sol::table
{
    auto       history = ::lua.create_table();
    const auto rset    = db::preparedStmt("SELECT h.itemid, h.count, h.caught_at, h.zoneid, "
                                          "COALESCE(ib.name, '') AS itemname, COALESCE(z.name, '') AS zonename "
                                          "FROM char_fishing_history h "
                                          "INNER JOIN chars c ON c.charid = h.charid "
                                          "LEFT JOIN item_basic ib ON ib.itemid = h.itemid "
                                          "LEFT JOIN zone_settings z ON z.zoneid = h.zoneid "
                                          "WHERE c.charname = ? "
                                          "ORDER BY h.caught_at DESC, h.id DESC "
                                          "LIMIT ?",
                                          charName,
                                          std::clamp<uint32>(limit, 1, 50));

    auto index = 1;
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto entry        = ::lua.create_table();
        entry["itemId"]   = rset->get<uint16>("itemid");
        entry["itemName"] = rset->get<std::string>("itemname");
        entry["count"]    = rset->get<uint8>("count");
        entry["zoneId"]   = rset->get<uint16>("zoneid");
        entry["zoneName"] = rset->get<std::string>("zonename");
        entry["caughtAt"] = rset->get<uint32>("caught_at");
        history[index++]  = entry;
    }

    return history;
}

auto getFishingRecords(const std::string& charName) -> sol::table
{
    auto records              = ::lua.create_table();
    records["linesCast"]      = 0;
    records["longestIlms"]    = 0;
    records["longestName"]    = "";
    records["heaviestPonzes"] = 0;
    records["heaviestName"]   = "";

    const auto rset = db::preparedStmt("SELECT r.lines_cast, r.longest_ilms, r.heaviest_ponzes, "
                                       "COALESCE(li.name, '') AS longestname, COALESCE(hi.name, '') AS heaviestname "
                                       "FROM char_fishing_records r "
                                       "INNER JOIN chars c ON c.charid = r.charid "
                                       "LEFT JOIN item_basic li ON li.itemid = r.longest_itemid "
                                       "LEFT JOIN item_basic hi ON hi.itemid = r.heaviest_itemid "
                                       "WHERE c.charname = ?",
                                       charName);

    if (rset && rset->next())
    {
        records["linesCast"]      = rset->get<uint32>("lines_cast");
        records["longestIlms"]    = rset->get<uint16>("longest_ilms");
        records["longestName"]    = rset->get<std::string>("longestname");
        records["heaviestPonzes"] = rset->get<uint16>("heaviest_ponzes");
        records["heaviestName"]   = rset->get<std::string>("heaviestname");
    }

    return records;
}

} // namespace

class FishingHistoryModule : public CPPModule
{
    void OnInit() override
    {
        TracyZoneScoped;

        db::preparedStmt("DELETE FROM char_fishing_history WHERE caught_at < ?", earth_time::timestamp() - retentionSeconds);

        fishingutils::AddFishingObserver(observe);

        ::lua.set_function("GetFishingHistory", getFishingHistory);
        ::lua.set_function("GetFishingRecords", getFishingRecords);
    }
};

REGISTER_CPP_MODULE(FishingHistoryModule);
