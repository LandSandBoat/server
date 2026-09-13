/************************************************************************
 *
 * Phoenix Gil Economy Ledger Module
 *
 * Records every gil balance change to `audit_gil` with no core edits.
 *
 * Every gil mutation funnels through applyItemUpdate (src/map/items/transaction.cpp),
 * which always pushes GP_SERV_COMMAND_ITEM_NUM with the post-clamp quantity.
 * OnPushPacket observes that packet; OnIncomingPacket and the Lua bindings
 * __gilAuditSetReason / __gilAuditRetireReason publish the reason before the
 * movement happens.
 *
 * Reasons are short lived. Lua retires its own once the helper returns, and
 * anything left over is dropped when the actor sends an unrelated packet or the
 * zone tick ends, so a reason from a refused action cannot label a later
 * movement. A movement in the wrong direction for its reason is also treated as
 * unattributed.
 *
 * Two flows outlive any packet reason: an NPC trade resolves its gil in
 * onEventFinish and the delivery box debits a send when the gil is staged, so
 * unattributed movements fall back to the character's open NpcTradeTransaction
 * or open delivery box before landing as Unknown.
 *
 * Paths that already have a row in another audit table (audit_vendor,
 * audit_bazaar, audit_trade, auction_house, audit_dbox) only get their source
 * and amount recorded here. Everything else (AH listing fee, AH proceeds,
 * GM commands, scripted gil) is recorded in full because nothing else does.
 *
 * Settings, seeded in OnInit and overridable in settings/map.lua:
 *   map.AUDIT_GIL      master switch, default on
 *   map.AUDIT_GIL_MOBS include mob drops and Mug, default on
 *
 ************************************************************************/

#include "common/database.h"
#include "common/earth_time.h"
#include "common/logging.h"
#include "common/scheduler.h"
#include "common/settings.h"
#include "common/xirand.h"

#include "map/entities/char_entity.h"
#include "map/enums/packet_c2s.h"
#include "map/enums/packet_s2c.h"
#include "map/item_container.h"
#include "map/items/transactions/npc_trade.h"
#include "map/lua/luautils.h"
#include "map/map_session.h"
#include "map/packets/basic.h"
#include "map/packets/s2c/0x01e_item_num.h"
#include "map/trade_container.h"
#include "map/universal_container.h"
#include "map/utils/dboxutils.h"
#include "map/utils/moduleutils.h"
#include "map/utils/zoneutils.h"
#include "packets/c2s/0x01a_action.h"
#include "packets/c2s/0x033_trade_res.h"
#include "packets/c2s/0x036_item_transfer.h"
#include "packets/c2s/0x04d_pbx.h"
#include "packets/c2s/0x04e_auc.h"
#include "packets/c2s/0x083_shop_buy.h"
#include "packets/c2s/0x085_shop_sell_set.h"
#include "packets/c2s/0x0aa_guild_buy.h"
#include "packets/c2s/0x0ac_guild_sell.h"
#include "packets/c2s/0x106_bazaar_buy.h"

#include <algorithm>
#include <cstdint>
#include <limits>
#include <optional>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include <magic_enum/magic_enum.hpp>

namespace
{

constexpr uint16 GIL_ITEM_ID = 0xFFFF;

constexpr std::size_t MAX_REASON_DEPTH  = 8;
constexpr std::size_t MAX_DETAIL_LENGTH = 160; // audit_gil.source_detail

// Two fixed statements rather than one with the delta formatted in: db::preparedStmt caches by query text
constexpr auto INSERT_WITH_DELTA = "INSERT INTO audit_gil("
                                   "txn_tag, txn_seq, charid, balance_after, delta, source, counterparty, "
                                   "itemid, source_detail, zoneid, date) "
                                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

constexpr auto INSERT_NULL_DELTA = "INSERT INTO audit_gil("
                                   "txn_tag, txn_seq, charid, balance_after, delta, source, counterparty, "
                                   "itemid, source_detail, zoneid, date) "
                                   "VALUES (?, ?, ?, ?, NULL, ?, ?, ?, ?, ?, ?)";

// Persisted as audit_gil.source, so append only and never renumber
enum class GilSource : uint8
{
    Unknown         = 0,
    MobDrop         = 1,
    VendorBuy       = 2,
    VendorSell      = 3,
    BazaarBuy       = 4,
    BazaarSell      = 5,
    AuctionFee      = 6,
    AuctionBid      = 7,
    AuctionProceeds = 8,
    DeliveryBox     = 9,
    PlayerTrade     = 10,
    NpcTrade        = 11,
    Script          = 12,
    GmCommand       = 13,
    DeliveryBoxSend = 14,

    Last = DeliveryBoxSend,
};

auto toGilSource(const uint8 value) -> GilSource
{
    if (value > std::to_underlying(GilSource::Last))
    {
        return GilSource::Unknown;
    }

    return static_cast<GilSource>(value);
}

enum class GilDirection : uint8
{
    Either,
    In,
    Out,
};

// Which way a source can legitimately move gil, so a stale reason cannot label a movement the other way
auto expectedDirection(const GilSource source) -> GilDirection
{
    switch (source)
    {
        case GilSource::MobDrop:
        case GilSource::VendorSell:
        case GilSource::BazaarSell:
        case GilSource::AuctionProceeds:
        case GilSource::DeliveryBox:
            return GilDirection::In;
        case GilSource::VendorBuy:
        case GilSource::BazaarBuy:
        case GilSource::AuctionFee:
        case GilSource::AuctionBid:
        case GilSource::NpcTrade:
        case GilSource::DeliveryBoxSend:
            return GilDirection::Out;
        default:
            return GilDirection::Either;
    }
}

// The reason for whatever gil movement is currently happening
struct GilReason
{
    GilSource source = GilSource::Unknown;
    uint32    txnTag = 0;
    uint32    txnSeq = 0;

    // Who did it
    uint32 actor        = 0;
    uint32 counterparty = 0;

    // Everyone else this reason may explain: the alliance sharing a mob drop
    std::vector<uint32> party;

    // Descriptive payload. Only filled in for paths that have no existing audit row of their own
    uint16      itemId = 0;
    std::string detail;

    // A stale reason must not label some other character's gil, so it only explains the characters it names
    auto explains(const uint32 charId) const -> bool
    {
        if (charId == 0)
        {
            return false;
        }

        if (charId == actor || charId == counterparty)
        {
            return true;
        }

        return std::ranges::contains(party, charId);
    }
};

// audit_bazaar already records both parties, so the bazaar counterparty is matched on but not stored
auto persistedCounterparty(const GilReason& reason, const GilSource source) -> uint32
{
    if (source == GilSource::BazaarBuy || source == GilSource::BazaarSell)
    {
        return 0;
    }

    return reason.counterparty;
}

// Main thread only: every producer and the observer run there.
// Reasons nest (a quest completing inside a mob death), so Lua pushes and pops rather than overwriting.
std::vector<GilReason> reasonStack;

// txn_id must be unique across every map process and restart, and a module cannot see its own port,
// so it is a random tag drawn once per process plus a sequence. They are stored as two uint32 columns
// because db::preparedStmt cannot bind 64-bit values; the table joins them back into txn_id
uint32 txnTag     = 0;
uint32 nextTxnSeq = 1;

auto currentReason() -> const GilReason&
{
    static const GilReason none{};

    if (reasonStack.empty())
    {
        return none;
    }

    return reasonStack.back();
}

void pushReason(GilReason reason)
{
    reason.txnTag = txnTag;
    reason.txnSeq = nextTxnSeq++;

    // Only the top is ever consulted, so silently drop the previous top when full (AoE kills stack one reason per death)
    if (reasonStack.size() >= MAX_REASON_DEPTH)
    {
        reasonStack.pop_back();
    }

    reasonStack.push_back(std::move(reason));
}

void popReason()
{
    if (!reasonStack.empty())
    {
        reasonStack.pop_back();
    }
}

void clearReasons()
{
    reasonStack.clear();
}

// Packets are top level, so a packet reason replaces whatever was left behind
void publishReason(GilReason reason)
{
    clearReasons();
    pushReason(std::move(reason));
}

// Last balance seen for each character, used to fill in `delta` on the next row.
// Updated on every observed movement, written or not, so a skipped category cannot leak into the next delta.
std::unordered_map<uint32, uint32> lastKnownBalance;

// The open NpcTradeTransaction does not expose its NPC and the guild menu carries no NPC identity,
// so remember the NPC each character last talked or traded with
std::unordered_map<uint32, uint32> lastNpcInteraction;

auto lastNpcFor(const uint32 charId) -> uint32
{
    const auto it = lastNpcInteraction.find(charId);
    if (it == lastNpcInteraction.end())
    {
        return 0;
    }

    return it->second;
}

auto isEnabled(const GilSource source) -> bool
{
    if (!settings::get<bool>("map.AUDIT_GIL"))
    {
        return false;
    }

    if (source == GilSource::MobDrop)
    {
        return settings::get<bool>("map.AUDIT_GIL_MOBS");
    }

    return true;
}

auto agreesWithDirection(const GilSource source, const std::optional<int32> delta) -> bool
{
    if (!delta.has_value() || *delta == 0)
    {
        return true;
    }

    switch (expectedDirection(source))
    {
        case GilDirection::In:
            return *delta > 0;
        case GilDirection::Out:
            return *delta < 0;
        default:
            return true;
    }
}

struct Attribution
{
    GilReason reason{};
    GilSource source = GilSource::Unknown;
};

// Movements no packet reason can see: an NPC trade resolves its gil in onEventFinish long after the
// trade packet, and the delivery box moves gil on whichever command stages or retrieves it
auto fallbackAttribution(CCharEntity* PChar, const std::optional<int32> delta) -> Attribution
{
    if (PChar->activeTransaction<NpcTradeTransaction>())
    {
        if (!agreesWithDirection(GilSource::NpcTrade, delta))
        {
            return {};
        }

        GilReason reason{ .source = GilSource::NpcTrade, .actor = PChar->id, .counterparty = lastNpcFor(PChar->id), .detail = "npc_trade" };

        return { .reason = std::move(reason), .source = GilSource::NpcTrade };
    }

    // Staging gil into the send box debits it; taking a cancelled or rejected send back credits it
    if (dboxutils::IsSendBoxOpen(PChar))
    {
        if (delta.has_value() && *delta < 0)
        {
            return { .reason = { .source = GilSource::DeliveryBoxSend, .actor = PChar->id, .detail = "delivery_box_send" }, .source = GilSource::DeliveryBoxSend };
        }

        return { .reason = { .source = GilSource::DeliveryBox, .actor = PChar->id, .detail = "delivery_box_return" }, .source = GilSource::DeliveryBox };
    }

    if (dboxutils::IsRecvBoxOpen(PChar) && agreesWithDirection(GilSource::DeliveryBox, delta))
    {
        return { .reason = { .source = GilSource::DeliveryBox, .actor = PChar->id, .detail = "delivery_box" }, .source = GilSource::DeliveryBox };
    }

    return {};
}

auto attribute(CCharEntity* PChar, const std::optional<int32> delta) -> Attribution
{
    const auto& reason = currentReason();
    if (!reason.explains(PChar->id))
    {
        return fallbackAttribution(PChar, delta);
    }

    // A bazaar purchase moves gil on both sides under one reason; the non-actor side is the sale
    auto source = reason.source;
    if (source == GilSource::BazaarBuy && PChar->id != reason.actor)
    {
        source = GilSource::BazaarSell;
    }

    if (!agreesWithDirection(source, delta))
    {
        return fallbackAttribution(PChar, delta);
    }

    return { .reason = reason, .source = source };
}

// The worker path calls this with copies captured in the closure, so the reason always outlives the call.
// Zero deltas are kept: a clamped credit at the gil cap pushes ITEM_NUM with an unchanged quantity.
// NULL is written when no earlier balance was seen, so unknown and zero stay distinct.
void writeRow(const GilReason& reason, const GilSource source, const uint32 charId, const uint32 balanceAfter, const std::optional<int32> delta, const uint16 zoneId, const uint32 timestamp)
{
    const auto sourceName = std::string(magic_enum::enum_name(source));

    const auto inserted = [&]() -> bool
    {
        if (delta.has_value())
        {
            return db::preparedStmt(INSERT_WITH_DELTA,
                                    reason.txnTag,
                                    reason.txnSeq,
                                    charId,
                                    balanceAfter,
                                    *delta,
                                    sourceName,
                                    persistedCounterparty(reason, source),
                                    reason.itemId,
                                    reason.detail,
                                    zoneId,
                                    timestamp) != nullptr;
        }

        return db::preparedStmt(INSERT_NULL_DELTA,
                                reason.txnTag,
                                reason.txnSeq,
                                charId,
                                balanceAfter,
                                sourceName,
                                persistedCounterparty(reason, source),
                                reason.itemId,
                                reason.detail,
                                zoneId,
                                timestamp) != nullptr;
    }();

    if (!inserted)
    {
        ShowErrorFmt("Failed to log gil movement (charid: {}, balance: {}, source: {})",
                     charId,
                     balanceAfter,
                     sourceName);
    }
}

void recordBalance(CCharEntity* PChar, const uint32 balanceAfter)
{
    const auto delta = [&]() -> std::optional<int32>
    {
        if (const auto it = lastKnownBalance.find(PChar->id); it != lastKnownBalance.end())
        {
            return static_cast<int32>(balanceAfter) - static_cast<int32>(it->second);
        }

        return std::nullopt;
    }();
    lastKnownBalance[PChar->id] = balanceAfter;

    const auto [reason, source] = attribute(PChar, delta);

    if (!isEnabled(source))
    {
        return;
    }

    const auto zoneId    = static_cast<uint16>(PChar->getZone());
    const auto timestamp = earth_time::timestamp();

    // Mob drops are the only high-frequency source and take no part in a db::transaction, so their
    // rows go through the worker thread. Everything else writes synchronously on purpose, so a credit
    // inside a db::transaction (dbox claims, AH bids) rolls back with it
    if (source == GilSource::MobDrop && PChar->PSession && PChar->PSession->scheduler)
    {
        PChar->PSession->scheduler->postToWorkerThread(
            [reason = reason, source, charId = PChar->id, balanceAfter, delta, zoneId, timestamp]()
            {
                writeRow(reason, source, charId, balanceAfter, delta, zoneId, timestamp);
            });
        return;
    }

    writeRow(reason, source, PChar->id, balanceAfter, delta, zoneId, timestamp);
}

// DistributeGil splits a mob's purse across the alliance members in zone, so the killer's reason has to cover them
void includeAlliance(GilReason& reason)
{
    auto* PChar = zoneutils::GetChar(reason.actor);
    if (!PChar)
    {
        return;
    }

    PChar->ForAlliance([&](CBattleEntity* PMember)
                       {
                           if (PMember->getZone() == PChar->getZone())
                           {
                               reason.party.push_back(PMember->id);
                           }
                       });
}

} // namespace

class GilAuditModule : public CPPModule
{
public:
    void OnInit() override
    {
        TracyZoneScoped;

        // settings::init already scraped settings/map.lua into settingsMap, so only seed what the admin left unset
        if (!settings::settingsMap.contains("map.AUDIT_GIL"))
        {
            settings::set("map.AUDIT_GIL", true);
        }

        if (!settings::settingsMap.contains("map.AUDIT_GIL_MOBS"))
        {
            settings::set("map.AUDIT_GIL_MOBS", true);
        }

        // __gilAuditSetReason(charId, source [, detail [, counterparty]])
        // charId is whose gil moves, which is the target for !givegil rather than the caller
        ::lua.set_function("__gilAuditSetReason",
                           [](const uint32 charId, const uint8 source, sol::variadic_args va)
                           {
                               if (!settings::get<bool>("map.AUDIT_GIL"))
                               {
                                   return;
                               }

                               GilReason reason{};
                               reason.source = toGilSource(source);
                               reason.actor  = charId;

                               if (va.size() > 0 && va[0].is<std::string>())
                               {
                                   reason.detail = va[0].as<std::string>().substr(0, MAX_DETAIL_LENGTH);
                               }

                               if (va.size() > 1 && va[1].is<uint32>())
                               {
                                   reason.counterparty = va[1].as<uint32>();
                               }

                               // npcUtil helpers do not know their NPC; the current event's target or the open
                               // NPC trade identifies who the player is dealing with
                               if (reason.counterparty == 0)
                               {
                                   if (auto* PChar = zoneutils::GetChar(charId))
                                   {
                                       if (PChar->isInEvent() && PChar->currentEvent->targetEntity && PChar->currentEvent->targetEntity->objtype != TYPE_PC)
                                       {
                                           reason.counterparty = PChar->currentEvent->targetEntity->id;
                                       }
                                       else if (PChar->activeTransaction<NpcTradeTransaction>())
                                       {
                                           reason.counterparty = lastNpcFor(charId);
                                       }
                                   }
                               }

                               if (reason.source == GilSource::MobDrop)
                               {
                                   includeAlliance(reason);
                               }

                               pushReason(std::move(reason));
                           });

        ::lua.set_function("__gilAuditRetireReason", []()
                           {
                               if (settings::get<bool>("map.AUDIT_GIL"))
                               {
                                   popReason();
                               }
                           });

        if (settings::get<bool>("map.AUDIT_GIL"))
        {
            txnTag = xirand::GetRandomNumber<uint32>(1, std::numeric_limits<uint32>::max());

            const auto mobDrops = [&]() -> const char*
            {
                if (settings::get<bool>("map.AUDIT_GIL_MOBS"))
                {
                    return "on";
                }

                return "off";
            }();

            ShowInfoFmt("Gil economy ledger enabled (mob drops: {})", mobDrops);
        }
    }

    // Nothing that publishes a reason outlives the tick it was published in
    void OnZoneTick(CZone* PZone) override
    {
        clearReasons();
    }

    // Seed the balance cache so the first movement after login materialises a real delta rather than NULL
    void OnCharZoneIn(CCharEntity* PChar) override
    {
        if (!PChar || !settings::get<bool>("map.AUDIT_GIL"))
        {
            return;
        }

        if (const auto* PGil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);
            PGil && PGil->getID() == GIL_ITEM_ID)
        {
            lastKnownBalance[PChar->id] = PGil->getQuantity();
        }
    }

    void OnCharZoneOut(CCharEntity* PChar) override
    {
        if (!PChar)
        {
            return;
        }

        lastKnownBalance.erase(PChar->id);
        lastNpcInteraction.erase(PChar->id);
    }

    void OnPushPacket(CCharEntity* PChar, const std::unique_ptr<CBasicPacket>& packet) override
    {
        if (!PChar || !packet || !settings::get<bool>("map.AUDIT_GIL"))
        {
            return;
        }

        if (packet->getType() != std::to_underlying(PacketS2C::GP_SERV_COMMAND_ITEM_NUM))
        {
            return;
        }

        // PacketData is public but the data() accessor is protected, so overlay the payload through ref
        const auto& data = packet->ref<GP_SERV_COMMAND_ITEM_NUM::PacketData>(sizeof(GP_SERV_HEADER));
        if (data.Category != LOC_INVENTORY || data.ItemIndex != 0)
        {
            return;
        }

        // Slot 0 is reserved for gil, but confirm rather than assume since this would silently poison the ledger
        const auto* PGil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);
        if (!PGil || PGil->getID() != GIL_ITEM_ID)
        {
            return;
        }

        recordBalance(PChar, data.ItemNum);
    }

    // Always returns false: returning true would suppress the handler and every later module (ah_pagination on 0x04E)
    auto OnIncomingPacket(MapSession* PSession, CCharEntity* PChar, CBasicPacket& packet) -> bool override
    {
        if (!PChar || !settings::get<bool>("map.AUDIT_GIL"))
        {
            return false;
        }

        switch (static_cast<PacketC2S>(packet.getType()))
        {
            case PacketC2S::GP_CLI_COMMAND_SHOP_BUY:
            {
                GilReason reason{ .source = GilSource::VendorBuy, .actor = PChar->id, .counterparty = PChar->Container->getShopVendorId(), .detail = "shop_buy" };

                if (const auto index = packet.as<GP_CLI_COMMAND_SHOP_BUY>()->ShopItemIndex; index < PChar->Container->getExSize())
                {
                    reason.itemId = PChar->Container->getItemID(static_cast<uint8>(index));
                }

                publishReason(std::move(reason));
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_SHOP_SELL_SET:
            {
                // The 0x084 price check stashed the item at the container's ex slot; mirror the handler's lookup
                publishReason({
                    .source       = GilSource::VendorSell,
                    .actor        = PChar->id,
                    .counterparty = PChar->Container->getShopVendorId(),
                    .itemId       = PChar->Container->getItemID(PChar->Container->getExSize()),
                    .detail       = "shop_sell",
                });
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_GUILD_BUY:
            {
                publishReason({
                    .source       = GilSource::VendorBuy,
                    .actor        = PChar->id,
                    .counterparty = lastNpcFor(PChar->id),
                    .itemId       = packet.as<GP_CLI_COMMAND_GUILD_BUY>()->ItemNo,
                    .detail       = "guild_buy",
                });
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_GUILD_SELL:
            {
                publishReason({
                    .source       = GilSource::VendorSell,
                    .actor        = PChar->id,
                    .counterparty = lastNpcFor(PChar->id),
                    .itemId       = packet.as<GP_CLI_COMMAND_GUILD_SELL>()->ItemNo,
                    .detail       = "guild_sell",
                });
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_BAZAAR_BUY:
            {
                // Both legs share one txn_id, so the zone tax is the difference between them
                GilReason reason{
                    .source       = GilSource::BazaarBuy,
                    .actor        = PChar->id,
                    .counterparty = PChar->BazaarID.UniqueNo,
                    .detail       = "bazaar_buy",
                };

                if (const auto* PSeller = zoneutils::GetChar(PChar->BazaarID.UniqueNo))
                {
                    if (const auto* PWare = PSeller->getStorage(LOC_INVENTORY)->GetItem(packet.as<GP_CLI_COMMAND_BAZAAR_BUY>()->BazaarItemIndex))
                    {
                        reason.itemId = PWare->getID();
                    }
                }

                publishReason(std::move(reason));
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_TRADE_RES:
            {
                // Only the accept can move gil; both trade legs commit inside it, so both sides land under one txn_id
                if (packet.as<GP_CLI_COMMAND_TRADE_RES>()->Kind != std::to_underlying(GP_CLI_COMMAND_TRADE_RES_KIND::Make))
                {
                    break;
                }

                publishReason({
                    .source       = GilSource::PlayerTrade,
                    .actor        = PChar->id,
                    .counterparty = PChar->TradePending.entity.UniqueNo,
                    .detail       = "trade_res",
                });
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_ITEM_TRANSFER:
            {
                // Gil traded to an NPC. This reason covers gil consumed during onTrade; gil consumed later
                // in onEventFinish is picked up by fallbackAttribution through the open NpcTradeTransaction
                const auto npcId              = packet.as<GP_CLI_COMMAND_ITEM_TRANSFER>()->UniqueNo;
                lastNpcInteraction[PChar->id] = npcId;

                publishReason({ .source = GilSource::NpcTrade, .actor = PChar->id, .counterparty = npcId, .detail = "npc_trade" });
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_AUC:
            {
                switch (packet.as<GP_CLI_COMMAND_AUC>()->Command)
                {
                    case GP_CLI_COMMAND_AUC_COMMAND::LotIn:
                    {
                        GilReason reason{ .source = GilSource::AuctionFee, .actor = PChar->id, .detail = "ah_listing_fee" };

                        const auto slot = packet.as<GP_CLI_COMMAND_AUC>()->Param.LotIn.ItemWorkIndex;
                        if (const auto* PListed = PChar->getStorage(LOC_INVENTORY)->GetItem(static_cast<uint8>(slot)))
                        {
                            reason.itemId = PListed->getID();
                        }

                        publishReason(std::move(reason));
                        break;
                    }
                    case GP_CLI_COMMAND_AUC_COMMAND::Bid:
                    {
                        publishReason({
                            .source = GilSource::AuctionBid,
                            .actor  = PChar->id,
                            .itemId = packet.as<GP_CLI_COMMAND_AUC>()->Param.Bid.ItemNo,
                            .detail = "ah_bid",
                        });
                        break;
                    }
                    default:
                        break;
                }
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_PBX:
            {
                const auto* pbx = packet.as<GP_CLI_COMMAND_PBX>();

                if (static_cast<GP_CLI_COMMAND_PBX_COMMAND>(pbx->Command) != GP_CLI_COMMAND_PBX_COMMAND::Get)
                {
                    break;
                }

                // Taking gil back out of the outgoing box is a return of the player's own gil
                if (static_cast<GP_CLI_COMMAND_PBX_BOXNO>(pbx->BoxNo) == GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
                {
                    publishReason({ .source = GilSource::DeliveryBox, .actor = PChar->id, .detail = "delivery_box_return" });
                    break;
                }

                if (static_cast<GP_CLI_COMMAND_PBX_BOXNO>(pbx->BoxNo) != GP_CLI_COMMAND_PBX_BOXNO::Incoming)
                {
                    break;
                }

                GilReason reason{ .source = GilSource::DeliveryBox, .actor = PChar->id, .detail = "delivery_box" };

                // AH proceeds are staged by the auction_house_buy trigger as gil from 'AH-Jeuno' with the sold item in subid
                if (PChar->UContainer && !PChar->UContainer->IsSlotEmpty(pbx->PostWorkNo))
                {
                    if (const auto* PDelivery = PChar->UContainer->GetItem(pbx->PostWorkNo);
                        PDelivery && PDelivery->getID() == GIL_ITEM_ID && PDelivery->getSender() == "AH-Jeuno")
                    {
                        reason.source = GilSource::AuctionProceeds;
                        reason.itemId = PDelivery->getSubID();
                        reason.detail = "ah_proceeds";
                    }
                }

                publishReason(std::move(reason));
                break;
            }
            case PacketC2S::GP_CLI_COMMAND_ACTION:
            {
                // Talking to an NPC opens the guild menu and starts most events; remember who for counterparty
                if (const auto* action = packet.as<GP_CLI_COMMAND_ACTION>();
                    action->ActionID == GP_CLI_COMMAND_ACTION_ACTIONID::Talk)
                {
                    lastNpcInteraction[PChar->id] = action->UniqueNo;
                }

                // Talking to someone new also means the previous economic action is over
                if (currentReason().explains(PChar->id))
                {
                    clearReasons();
                }
                break;
            }
            default:
            {
                // Any other packet from the actor means the economic action is over
                if (currentReason().explains(PChar->id))
                {
                    clearReasons();
                }
                break;
            }
        }

        return false;
    }
};

REGISTER_CPP_MODULE(GilAuditModule);
