/************************************************************************
 * Guild Shop Persistence Module
 *
 * The Lua guild shop system keeps every shop's stock and the prices it
 * locked for the day in the in-memory table xi.guildShops.state, so every
 * restart resets shops to their configured starting stock. This module
 * saves that table to guild_shop_state so shops pick up where they left off.
 *
 * The table is loaded back once per boot, on the first time server tick
 * after OnInit. That has to happen after luautils::OnServerStart, because
 * that is when era_guild_shops.lua patches the shop config.
 *
 * A shop whose saved rows still cover every item in its config comes back
 * exactly as it was, locked prices included. A shop whose config changed
 * while the server was down gets its stock back with lastRoll = -1. The
 * first roll then keeps that stock, skips the restock and recomputes the
 * prices. Saved rows for items no longer in a shop's config are deleted.
 * If the load fails the module disarms itself for the rest of the uptime
 * instead of overwriting a snapshot it could not read.
 *
 * The Lua helper in modules/phoenix/lua/custom/guild_shop_persistence.lua
 * keeps a copy of what was last saved and returns only the rows that
 * changed, so each tick makes one call into Lua. Only stock moves during
 * the day, so a shop's daily roll is the only write with many rows. The
 * changed rows are written in one transaction on the tick, the same way
 * PersistVolatileServerVars writes. A failed write keeps its rows and tries
 * again next tick. A crash loses at most one tick of changes, and the next
 * daily roll rewrites the whole shop anyway.
 *
 * Turned on by the main.GUILD_SHOP_PERSISTENCE setting, off by default.
 * Turning it on with a settings reload does nothing until the next restart,
 * because writing without loading first would overwrite the snapshot.
 *
 * Delete rows from guild_shop_state while the server is down to reset a shop.
 ************************************************************************/

#include "common/database.h"
#include "common/logging.h"
#include "common/settings.h"
#include "map/utils/moduleutils.h"

#include <stdexcept>
#include <string>
#include <vector>

namespace
{

struct ShopRow
{
    std::string shop;
    uint16      itemId    = 0;
    uint16      stock     = 0;
    uint32      buyPrice  = 0;
    uint32      sellPrice = 0;
    uint8       offered   = 0;
    uint32      lastRoll  = 0;
};

enum class State : uint8
{
    Off,
    AwaitingRestore,
    Running,
    Disarmed,
};

} // namespace

class GuildShopPersistenceModule : public CPPModule
{
public:
    void OnInit() override
    {
        TracyZoneScoped;

        if (settings::get<bool>("main.GUILD_SHOP_PERSISTENCE"))
        {
            state_ = State::AwaitingRestore;
            ShowInfo("Guild shop persistence enabled");
        }
    }

    void OnTimeServerTick() override
    {
        switch (state_)
        {
            case State::AwaitingRestore:
                restore();
                break;
            case State::Running:
                persist();
                break;
            case State::Off:
            case State::Disarmed:
                break;
        }
    }

private:
    void disarm(const std::string& why)
    {
        state_ = State::Disarmed;
        ShowErrorFmt("Guild shop persistence disarmed: {}", why);
    }

    void restore()
    {
        const sol::optional<sol::table> helper = ::lua["xi"]["guildShops"]["persistence"];
        if (!helper)
        {
            disarm("helper not loaded; is modules/phoenix/lua enabled in init.txt?");
            return;
        }

        // Putting a nil straight into a sol::protected_function throws with the
        // sol safety checks on, so read them as optionals first.
        const auto restoreFn = helper->get<sol::optional<sol::protected_function>>("restore");
        const auto collectFn = helper->get<sol::optional<sol::protected_function>>("collect");
        if (!restoreFn || !collectFn)
        {
            disarm("helper is missing restore/collect");
            return;
        }

        restoreFn_ = *restoreFn;
        collectFn_ = *collectFn;

        const auto rset = db::preparedStmt("SELECT shop, itemid, stock, buy_price, sell_price, offered, last_roll FROM guild_shop_state");
        if (!rset)
        {
            // Writing from here on would overwrite the snapshot we could not read.
            disarm("could not read guild_shop_state");
            return;
        }

        auto        rows     = ::lua.create_table();
        std::size_t rowCount = 0;
        while (rset->next())
        {
            auto row         = ::lua.create_table();
            row["shop"]      = rset->get<std::string>("shop");
            row["itemId"]    = rset->get<uint16>("itemid");
            row["stock"]     = rset->get<uint16>("stock");
            row["buyPrice"]  = rset->get<uint32>("buy_price");
            row["sellPrice"] = rset->get<uint32>("sell_price");
            row["offered"]   = rset->get<uint8>("offered");
            row["lastRoll"]  = rset->get<uint32>("last_roll");

            rows[++rowCount] = row;
        }

        const auto restoreResult = restoreFn_(rows);
        if (!restoreResult.valid())
        {
            const sol::error err = restoreResult;
            disarm(fmt::format("restore failed: {}", err.what()));
            return;
        }

        const sol::table summary  = restoreResult;
        const sol::table deletes  = summary["deletes"];
        const auto       restored = summary.get_or("restored", 0);
        const auto       reRolled = summary.get_or("reRolled", 0);

        std::size_t pruned = 0;
        for (const auto& [key, value] : deletes)
        {
            const auto entry  = value.as<sol::table>();
            const auto shop   = entry.get<std::string>("shop");
            const auto itemId = entry.get<uint16>("itemId");

            if (db::preparedStmt("DELETE FROM guild_shop_state WHERE shop = ? AND itemid = ?", shop, itemId))
            {
                ++pruned;
            }
            else
            {
                // Restore finds the same stale rows again next boot.
                ShowErrorFmt("Guild shop persistence: failed to prune stale row {}/{}", shop, itemId);
            }
        }

        ShowInfoFmt("Guild shop persistence: {} rows read, {} shops restored, {} set to re-roll, {} stale rows pruned", rowCount, restored, reRolled, pruned);

        state_ = State::Running;
    }

    void persist()
    {
        if (!collectDeltas() || pending_.empty())
        {
            return;
        }

        // A failed batch stays in pending_ ahead of the next tick's rows, so
        // writes land in the order the changes happened.
        if (writeBatch(pending_))
        {
            pending_.clear();
        }
    }

    auto collectDeltas() -> bool
    {
        const auto collectResult = collectFn_();
        if (!collectResult.valid())
        {
            const sol::error err = collectResult;
            disarm(fmt::format("collect failed: {}", err.what()));
            return false;
        }

        const sol::table deltas = collectResult;
        for (const auto& [key, value] : deltas)
        {
            const auto entry = value.as<sol::table>();

            pending_.emplace_back(ShopRow{
                .shop      = entry.get<std::string>("shop"),
                .itemId    = entry.get<uint16>("itemId"),
                .stock     = entry.get<uint16>("stock"),
                .buyPrice  = entry.get<uint32>("buyPrice"),
                .sellPrice = entry.get<uint32>("sellPrice"),
                .offered   = entry.get<uint8>("offered"),
                .lastRoll  = entry.get<uint32>("lastRoll"),
            });
        }

        return true;
    }

    auto writeBatch(const std::vector<ShopRow>& batch) -> bool
    {
        const auto ok = db::transaction([&batch]()
                                        {
                                            for (const auto& row : batch)
                                            {
                                                if (!db::preparedStmt("INSERT INTO guild_shop_state SET shop = ?, itemid = ?, stock = ?, buy_price = ?, sell_price = ?, offered = ?, last_roll = ? "
                                                                      "ON DUPLICATE KEY UPDATE stock = VALUES(stock), buy_price = VALUES(buy_price), sell_price = VALUES(sell_price), offered = VALUES(offered), last_roll = VALUES(last_roll)",
                                                                      row.shop,
                                                                      row.itemId,
                                                                      row.stock,
                                                                      row.buyPrice,
                                                                      row.sellPrice,
                                                                      row.offered,
                                                                      row.lastRoll))
                                                {
                                                    throw std::runtime_error("guild_shop_state upsert failed");
                                                }
                                            }
                                        });

        if (!ok)
        {
            ShowErrorFmt("Guild shop persistence: failed to write {} rows, retrying next tick", batch.size());
        }

        return ok;
    }

    State state_ = State::Off;

    sol::protected_function restoreFn_;
    sol::protected_function collectFn_;

    std::vector<ShopRow> pending_;
};

REGISTER_CPP_MODULE(GuildShopPersistenceModule);
