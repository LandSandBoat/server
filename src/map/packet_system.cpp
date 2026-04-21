/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "packet_system.h"

#include "common/logging.h"
#include "common/tracy.h"

#include "entities/charentity.h"
#include "map_session.h"
#include "packets/basic.h"
#include "packets/c2s/0x00a_login.h"
#include "packets/c2s/0x00c_gameok.h"
#include "packets/c2s/0x00d_netend.h"
#include "packets/c2s/0x00f_clstat.h"
#include "packets/c2s/0x011_zone_transition.h"
#include "packets/c2s/0x015_pos.h"
#include "packets/c2s/0x016_charreq.h"
#include "packets/c2s/0x017_charreq2.h"
#include "packets/c2s/0x01a_action.h"
#include "packets/c2s/0x01b_friendpass.h"
#include "packets/c2s/0x01c_unknown.h"
#include "packets/c2s/0x01e_gm.h"
#include "packets/c2s/0x01f_gmcommand.h"
#include "packets/c2s/0x028_item_dump.h"
#include "packets/c2s/0x029_item_move.h"
#include "packets/c2s/0x02b_translate.h"
#include "packets/c2s/0x02c_itemsearch.h"
#include "packets/c2s/0x032_trade_req.h"
#include "packets/c2s/0x033_trade_res.h"
#include "packets/c2s/0x034_trade_list.h"
#include "packets/c2s/0x036_item_transfer.h"
#include "packets/c2s/0x037_item_use.h"
#include "packets/c2s/0x03a_item_stack.h"
#include "packets/c2s/0x03b_subcontainer.h"
#include "packets/c2s/0x03c_black_list.h"
#include "packets/c2s/0x03d_black_edit.h"
#include "packets/c2s/0x041_trophy_entry.h"
#include "packets/c2s/0x042_trophy_absence.h"
#include "packets/c2s/0x04b_fragments.h"
#include "packets/c2s/0x04d_pbx.h"
#include "packets/c2s/0x04e_auc.h"
#include "packets/c2s/0x050_equip_set.h"
#include "packets/c2s/0x051_equipset_set.h"
#include "packets/c2s/0x052_equipset_check.h"
#include "packets/c2s/0x053_lockstyle.h"
#include "packets/c2s/0x058_recipe.h"
#include "packets/c2s/0x059_effectend.h"
#include "packets/c2s/0x05a_reqconquest.h"
#include "packets/c2s/0x05b_eventend.h"
#include "packets/c2s/0x05c_eventendxzy.h"
#include "packets/c2s/0x05d_motion.h"
#include "packets/c2s/0x05e_maprect.h"
#include "packets/c2s/0x060_passwards.h"
#include "packets/c2s/0x061_clistatus.h"
#include "packets/c2s/0x063_dig.h"
#include "packets/c2s/0x064_scenarioitem.h"
#include "packets/c2s/0x066_fishing.h"
#include "packets/c2s/0x06e_group_solicit_req.h"
#include "packets/c2s/0x06f_group_leave.h"
#include "packets/c2s/0x070_group_breakup.h"
#include "packets/c2s/0x071_group_strike.h"
#include "packets/c2s/0x074_group_solicit_res.h"
#include "packets/c2s/0x076_group_list_req.h"
#include "packets/c2s/0x077_group_change2.h"
#include "packets/c2s/0x078_group_checkid.h"
#include "packets/c2s/0x083_shop_buy.h"
#include "packets/c2s/0x084_shop_sell_req.h"
#include "packets/c2s/0x085_shop_sell_set.h"
#include "packets/c2s/0x096_combine_ask.h"
#include "packets/c2s/0x09b_chocobo_race_req.h"
#include "packets/c2s/0x0a0_switch_proposal.h"
#include "packets/c2s/0x0a1_switch_vote.h"
#include "packets/c2s/0x0a2_dice.h"
#include "packets/c2s/0x0aa_guild_buy.h"
#include "packets/c2s/0x0ab_guild_buylist.h"
#include "packets/c2s/0x0ac_guild_sell.h"
#include "packets/c2s/0x0ad_guild_selllist.h"
#include "packets/c2s/0x0b5_chat_std.h"
#include "packets/c2s/0x0b6_chat_name.h"
#include "packets/c2s/0x0b7_assist_channel.h"
#include "packets/c2s/0x0be_merits.h"
#include "packets/c2s/0x0bf_job_points_spend.h"
#include "packets/c2s/0x0c0_job_points_req.h"
#include "packets/c2s/0x0c1_alter_ego_points.h"
#include "packets/c2s/0x0c3_group_comlink_make.h"
#include "packets/c2s/0x0c4_group_comlink_active.h"
#include "packets/c2s/0x0cb_myroom_is.h"
#include "packets/c2s/0x0d2_map_group.h"
#include "packets/c2s/0x0d3_faq_gmcall.h"
#include "packets/c2s/0x0d4_faq_gmparam.h"
#include "packets/c2s/0x0d5_ack_gmmsg.h"
#include "packets/c2s/0x0d8_dungeon_param.h"
#include "packets/c2s/0x0db_config_language.h"
#include "packets/c2s/0x0dc_config.h"
#include "packets/c2s/0x0dd_equip_inspect.h"
#include "packets/c2s/0x0de_inspect_message.h"
#include "packets/c2s/0x0e0_set_usermsg.h"
#include "packets/c2s/0x0e1_get_lsmsg.h"
#include "packets/c2s/0x0e2_set_lsmsg.h"
#include "packets/c2s/0x0e4_get_lspriv.h"
#include "packets/c2s/0x0e7_reqlogout.h"
#include "packets/c2s/0x0e8_camp.h"
#include "packets/c2s/0x0ea_sit.h"
#include "packets/c2s/0x0eb_reqsubmapnum.h"
#include "packets/c2s/0x0f0_rescue.h"
#include "packets/c2s/0x0f1_buffcancel.h"
#include "packets/c2s/0x0f2_submapchange.h"
#include "packets/c2s/0x0f4_tracking_list.h"
#include "packets/c2s/0x0f5_tracking_start.h"
#include "packets/c2s/0x0f6_tracking_end.h"
#include "packets/c2s/0x0fa_myroom_layout.h"
#include "packets/c2s/0x0fb_myroom_bankin.h"
#include "packets/c2s/0x0fc_myroom_plant_add.h"
#include "packets/c2s/0x0fd_myroom_plant_check.h"
#include "packets/c2s/0x0fe_myroom_plant_crop.h"
#include "packets/c2s/0x0ff_myroom_plant_stop.h"
#include "packets/c2s/0x100_myroom_job.h"
#include "packets/c2s/0x102_extended_job.h"
#include "packets/c2s/0x104_bazaar_exit.h"
#include "packets/c2s/0x105_bazaar_list.h"
#include "packets/c2s/0x106_bazaar_buy.h"
#include "packets/c2s/0x109_bazaar_open.h"
#include "packets/c2s/0x10a_bazaar_itemset.h"
#include "packets/c2s/0x10b_bazaar_close.h"
#include "packets/c2s/0x10c_roe_start.h"
#include "packets/c2s/0x10d_roe_remove.h"
#include "packets/c2s/0x10e_roe_claim.h"
#include "packets/c2s/0x10f_currencies_1.h"
#include "packets/c2s/0x110_fishing_2.h"
#include "packets/c2s/0x112_battlefield_req.h"
#include "packets/c2s/0x113_sitchair.h"
#include "packets/c2s/0x114_map_markers.h"
#include "packets/c2s/0x115_currencies_2.h"
#include "packets/c2s/0x116_unity_menu.h"
#include "packets/c2s/0x117_unity_quest.h"
#include "packets/c2s/0x118_unity_toggle.h"
#include "packets/c2s/0x119_emote_list.h"
#include "packets/c2s/0x11b_mastery_display.h"
#include "packets/c2s/0x11c_party_request.h"
#include "packets/c2s/0x11d_jump.h"
#include "utils/moduleutils.h"

namespace
{

using PacketHandler = void (*)(MapSession* const, CCharEntity* const, CBasicPacket&);

template <typename T>
constexpr auto packetSizeRange() -> std::pair<std::size_t, std::size_t>
{
    constexpr auto maxSize = roundUpToNearestFour(static_cast<uint32>(sizeof(T)));
    if constexpr (requires { T::getMinSize(); })
    {
        return { T::getMinSize(), maxSize };
    }
    else
    {
        return { maxSize, maxSize };
    }
}

template <typename T>
void ValidatedPacketHandler(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    constexpr auto packetId   = static_cast<uint16>(T::packetId);
    constexpr auto sizeRange  = packetSizeRange<T>();
    constexpr auto minSize    = sizeRange.first;
    constexpr auto maxSize    = sizeRange.second;
    const auto     actualSize = data.getSize();

    if (actualSize < minSize || actualSize > maxSize)
    {
        ShowWarningFmt("Bad packet size for {} ({:#05x}) from {}: got {}, expected [{}, {}]",
                       T::name,
                       packetId,
                       PChar->getName(),
                       actualSize,
                       minSize,
                       maxSize);
        return;
    }

    const T* packet = data.as<T>();

    if (const auto result = packet->validate(PSession, PChar); result.valid())
    {
        PChar->m_LastPacketType = packetId;

        // Modules can optionally block processing of packets by returning true from OnIncomingPacket
        if (moduleutils::OnIncomingPacket(PSession, PChar, data))
        {
            return;
        }

        packet->process(PSession, PChar);
    }
    else
    {
        ShowWarningFmt("Invalid {} packet from {}: {} ", T::name, PChar->getName(), result.errorString());
    }
}

template <typename T>
constexpr void registerPacket(std::array<PacketHandler, 512>& handlers)
{
    handlers[static_cast<uint16>(T::packetId)] = &ValidatedPacketHandler<T>;
}

consteval auto buildPacketHandlers() -> std::array<PacketHandler, 512>
{
    std::array<PacketHandler, 512> handlers{};

    registerPacket<GP_CLI_COMMAND_LOGIN>(handlers);
    registerPacket<GP_CLI_COMMAND_GAMEOK>(handlers);
    registerPacket<GP_CLI_COMMAND_NETEND>(handlers);
    registerPacket<GP_CLI_COMMAND_CLSTAT>(handlers);
    registerPacket<GP_CLI_COMMAND_ZONE_TRANSITION>(handlers);
    registerPacket<GP_CLI_COMMAND_POS>(handlers);
    registerPacket<GP_CLI_COMMAND_CHARREQ>(handlers);
    registerPacket<GP_CLI_COMMAND_CHARREQ2>(handlers);
    registerPacket<GP_CLI_COMMAND_ACTION>(handlers);
    registerPacket<GP_CLI_COMMAND_FRIENDPASS>(handlers);
    registerPacket<GP_CLI_COMMAND_UNKNOWN>(handlers);
    registerPacket<GP_CLI_COMMAND_GM>(handlers);
    registerPacket<GP_CLI_COMMAND_GMCOMMAND>(handlers);
    registerPacket<GP_CLI_COMMAND_ITEM_DUMP>(handlers);
    registerPacket<GP_CLI_COMMAND_ITEM_MOVE>(handlers);
    registerPacket<GP_CLI_COMMAND_TRANSLATE>(handlers);
    registerPacket<GP_CLI_COMMAND_ITEMSEARCH>(handlers);
    registerPacket<GP_CLI_COMMAND_TRADE_REQ>(handlers);
    registerPacket<GP_CLI_COMMAND_TRADE_RES>(handlers);
    registerPacket<GP_CLI_COMMAND_TRADE_LIST>(handlers);
    registerPacket<GP_CLI_COMMAND_ITEM_TRANSFER>(handlers);
    registerPacket<GP_CLI_COMMAND_ITEM_USE>(handlers);
    registerPacket<GP_CLI_COMMAND_ITEM_STACK>(handlers);
    registerPacket<GP_CLI_COMMAND_SUBCONTAINER>(handlers);
    registerPacket<GP_CLI_COMMAND_BLACK_LIST>(handlers);
    registerPacket<GP_CLI_COMMAND_BLACK_EDIT>(handlers);
    registerPacket<GP_CLI_COMMAND_TROPHY_ENTRY>(handlers);
    registerPacket<GP_CLI_COMMAND_TROPHY_ABSENCE>(handlers);
    registerPacket<GP_CLI_COMMAND_FRAGMENTS>(handlers);
    registerPacket<GP_CLI_COMMAND_PBX>(handlers);
    registerPacket<GP_CLI_COMMAND_AUC>(handlers);
    registerPacket<GP_CLI_COMMAND_EQUIP_SET>(handlers);
    registerPacket<GP_CLI_COMMAND_EQUIPSET_SET>(handlers);
    registerPacket<GP_CLI_COMMAND_EQUIPSET_CHECK>(handlers);
    registerPacket<GP_CLI_COMMAND_LOCKSTYLE>(handlers);
    registerPacket<GP_CLI_COMMAND_RECIPE>(handlers);
    registerPacket<GP_CLI_COMMAND_EFFECTEND>(handlers);
    registerPacket<GP_CLI_COMMAND_REQCONQUEST>(handlers);
    registerPacket<GP_CLI_COMMAND_EVENTEND>(handlers);
    registerPacket<GP_CLI_COMMAND_EVENTENDXZY>(handlers);
    registerPacket<GP_CLI_COMMAND_MOTION>(handlers);
    registerPacket<GP_CLI_COMMAND_MAPRECT>(handlers);
    registerPacket<GP_CLI_COMMAND_PASSWARDS>(handlers);
    registerPacket<GP_CLI_COMMAND_CLISTATUS>(handlers);
    registerPacket<GP_CLI_COMMAND_DIG>(handlers);
    registerPacket<GP_CLI_COMMAND_SCENARIOITEM>(handlers);
    registerPacket<GP_CLI_COMMAND_FISHING>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_SOLICIT_REQ>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_LEAVE>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_BREAKUP>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_STRIKE>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_SOLICIT_RES>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_LIST_REQ>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_CHANGE2>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_CHECKID>(handlers);
    registerPacket<GP_CLI_COMMAND_SHOP_BUY>(handlers);
    registerPacket<GP_CLI_COMMAND_SHOP_SELL_REQ>(handlers);
    registerPacket<GP_CLI_COMMAND_SHOP_SELL_SET>(handlers);
    registerPacket<GP_CLI_COMMAND_COMBINE_ASK>(handlers);
    registerPacket<GP_CLI_COMMAND_CHOCOBO_RACE_REQ>(handlers);
    registerPacket<GP_CLI_COMMAND_SWITCH_PROPOSAL>(handlers);
    registerPacket<GP_CLI_COMMAND_SWITCH_VOTE>(handlers);
    registerPacket<GP_CLI_COMMAND_DICE>(handlers);
    registerPacket<GP_CLI_COMMAND_GUILD_BUY>(handlers);
    registerPacket<GP_CLI_COMMAND_GUILD_BUYLIST>(handlers);
    registerPacket<GP_CLI_COMMAND_GUILD_SELL>(handlers);
    registerPacket<GP_CLI_COMMAND_GUILD_SELLLIST>(handlers);
    registerPacket<GP_CLI_COMMAND_CHAT_STD>(handlers);
    registerPacket<GP_CLI_COMMAND_CHAT_NAME>(handlers);
    registerPacket<GP_CLI_COMMAND_ASSIST_CHANNEL>(handlers);
    registerPacket<GP_CLI_COMMAND_MERITS>(handlers);
    registerPacket<GP_CLI_COMMAND_JOB_POINTS_SPEND>(handlers);
    registerPacket<GP_CLI_COMMAND_JOB_POINTS_REQ>(handlers);
    registerPacket<GP_CLI_COMMAND_ALTER_EGO_POINTS>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_COMLINK_MAKE>(handlers);
    registerPacket<GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_IS>(handlers);
    registerPacket<GP_CLI_COMMAND_MAP_GROUP>(handlers);
    registerPacket<GP_CLI_COMMAND_FAQ_GMCALL>(handlers);
    registerPacket<GP_CLI_COMMAND_FAQ_GMPARAM>(handlers);
    registerPacket<GP_CLI_COMMAND_ACK_GMMSG>(handlers);
    registerPacket<GP_CLI_COMMAND_DUNGEON_PARAM>(handlers);
    registerPacket<GP_CLI_COMMAND_CONFIG_LANGUAGE>(handlers);
    registerPacket<GP_CLI_COMMAND_CONFIG>(handlers);
    registerPacket<GP_CLI_COMMAND_EQUIP_INSPECT>(handlers);
    registerPacket<GP_CLI_COMMAND_INSPECT_MESSAGE>(handlers);
    registerPacket<GP_CLI_COMMAND_SET_USERMSG>(handlers);
    registerPacket<GP_CLI_COMMAND_GET_LSMSG>(handlers);
    registerPacket<GP_CLI_COMMAND_SET_LSMSG>(handlers);
    registerPacket<GP_CLI_COMMAND_GET_LSPRIV>(handlers);
    registerPacket<GP_CLI_COMMAND_REQLOGOUT>(handlers);
    registerPacket<GP_CLI_COMMAND_CAMP>(handlers);
    registerPacket<GP_CLI_COMMAND_SIT>(handlers);
    registerPacket<GP_CLI_COMMAND_REQSUBMAPNUM>(handlers);
    registerPacket<GP_CLI_COMMAND_RESCUE>(handlers);
    registerPacket<GP_CLI_COMMAND_BUFFCANCEL>(handlers);
    registerPacket<GP_CLI_COMMAND_SUBMAPCHANGE>(handlers);
    registerPacket<GP_CLI_COMMAND_TRACKING_LIST>(handlers);
    registerPacket<GP_CLI_COMMAND_TRACKING_START>(handlers);
    registerPacket<GP_CLI_COMMAND_TRACKING_END>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_LAYOUT>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_BANKIN>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_PLANT_ADD>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_PLANT_CHECK>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_PLANT_CROP>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_PLANT_STOP>(handlers);
    registerPacket<GP_CLI_COMMAND_MYROOM_JOB>(handlers);
    registerPacket<GP_CLI_COMMAND_EXTENDED_JOB>(handlers);
    registerPacket<GP_CLI_COMMAND_BAZAAR_EXIT>(handlers);
    registerPacket<GP_CLI_COMMAND_BAZAAR_LIST>(handlers);
    registerPacket<GP_CLI_COMMAND_BAZAAR_BUY>(handlers);
    registerPacket<GP_CLI_COMMAND_BAZAAR_OPEN>(handlers);
    registerPacket<GP_CLI_COMMAND_BAZAAR_ITEMSET>(handlers);
    registerPacket<GP_CLI_COMMAND_BAZAAR_CLOSE>(handlers);
    registerPacket<GP_CLI_COMMAND_ROE_START>(handlers);
    registerPacket<GP_CLI_COMMAND_ROE_REMOVE>(handlers);
    registerPacket<GP_CLI_COMMAND_ROE_CLAIM>(handlers);
    registerPacket<GP_CLI_COMMAND_CURRENCIES_1>(handlers);
    registerPacket<GP_CLI_COMMAND_FISHING_2>(handlers);
    registerPacket<GP_CLI_COMMAND_BATTLEFIELD_REQ>(handlers);
    registerPacket<GP_CLI_COMMAND_SITCHAIR>(handlers);
    registerPacket<GP_CLI_COMMAND_MAP_MARKERS>(handlers);
    registerPacket<GP_CLI_COMMAND_CURRENCIES_2>(handlers);
    registerPacket<GP_CLI_COMMAND_UNITY_MENU>(handlers);
    registerPacket<GP_CLI_COMMAND_UNITY_QUEST>(handlers);
    registerPacket<GP_CLI_COMMAND_UNITY_TOGGLE>(handlers);
    registerPacket<GP_CLI_COMMAND_EMOTE_LIST>(handlers);
    registerPacket<GP_CLI_COMMAND_MASTERY_DISPLAY>(handlers);
    registerPacket<GP_CLI_COMMAND_PARTY_REQUEST>(handlers);
    registerPacket<GP_CLI_COMMAND_JUMP>(handlers);

    return handlers;
}

constexpr auto packetHandlers_ = buildPacketHandlers();

} // namespace

void PacketSystem::dispatch(uint16 packetId, MapSession* PSession, CCharEntity* PChar, CBasicPacket& data)
{
    if (const auto handler = packetHandlers_[packetId])
    {
        if (rateLimiter_.isLimited(PChar, packetId))
        {
            ShowWarningFmt("Rate-limiting packet {} ({:#05x}) from {}",
                           magic_enum::enum_name(static_cast<PacketC2S>(packetId)),
                           packetId,
                           PChar->getName());
            return;
        }

        handler(PSession, PChar, data);
    }
    else
    {
        ShowWarningFmt("parse: Unhandled game packet {:#05x} from user: {}", packetId, PChar->getName());
    }
}
