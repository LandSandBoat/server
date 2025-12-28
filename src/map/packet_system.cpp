/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/async.h"
#include "common/database.h"
#include "common/logging.h"
#include "common/mmo.h"
#include "common/task_manager.h"
#include "common/timer.h"
#include "common/utils.h"

#include <cstring>
#include <utility>

#include "ipc_client.h"
#include "map_networking.h"
#include "map_session.h"
#include "packet_system.h"

#include "entities/charentity.h"

#include "packets/basic.h"
#include "packets/c2s/0x00a_login.h"
#include "packets/c2s/0x00c_gameok.h"
#include "packets/c2s/0x00d_netend.h"
#include "packets/c2s/0x00f_clstat.h"
#include "packets/c2s/0x011_zone_transition.h"
#include "packets/c2s/0x015_pos.h"
#include "packets/c2s/0x016_charreq.h"
#include "packets/c2s/0x017_charreq2.h"
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

uint8 PacketSize[512];

std::function<void(MapSession* const, CCharEntity* const, CBasicPacket&)> PacketParser[512];

/************************************************************************
 *                                                                       *
 *  Display the contents of the incoming packet to the console.          *
 *                                                                       *
 ************************************************************************/

void PrintPacket(CBasicPacket& packet)
{
    std::string message;

    for (std::size_t idx = 0U; idx < packet.getSize(); idx++)
    {
        uint8 byte = *packet[idx];
        message.append(fmt::format("{:02x} ", byte));

        if (((idx + 1U) % 16U) == 0U)
        {
            message += "\n";
            ShowDebug(message.c_str());
            message.clear();
        }
    }

    if (!message.empty())
    {
        message += "\n";
        ShowDebug(message.c_str());
    }
}

/************************************************************************
 *                                                                       *
 *  Unknown Packet                                                       *
 *                                                                       *
 ************************************************************************/

void SmallPacket0x000(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    ShowWarning("parse: Unhandled game packet %03hX from user: %s", (data.ref<uint16>(0) & 0x1FF), PChar->getName());
}

template <typename T>
void ValidatedPacketHandler(MapSession* const PSession, CCharEntity* const PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const T* packet = data.as<T>();

    if (const auto result = packet->validate(PSession, PChar); result.valid())
    {
        // Modules can optionally block processing of packets by returning true from OnIncomingPacket
        if (moduleutils::OnIncomingPacket(PSession, PChar, data))
        {
            return;
        }

        packet->process(PSession, PChar);
    }
    else
    {
        ShowWarningFmt("Invalid {} packet from {}: {} ", packet->getName(), PChar->name, result.errorString());
    }
}

/************************************************************************
 *                                                                       *
 *  Packet Array Initialization                                          *
 *                                                                       *
 ************************************************************************/

void PacketParserInitialize()
{
    TracyZoneScoped;

    for (uint16 i = 0; i < 512; ++i)
    {
        PacketSize[i]   = 0;
        PacketParser[i] = &SmallPacket0x000;
    }

    // clang-format off
    PacketSize[0x00A] = 0x2E; PacketParser[0x00A] = &ValidatedPacketHandler<GP_CLI_COMMAND_LOGIN>;
    PacketSize[0x00C] = 0x00; PacketParser[0x00C] = &ValidatedPacketHandler<GP_CLI_COMMAND_GAMEOK>;
    PacketSize[0x00D] = 0x04; PacketParser[0x00D] = &ValidatedPacketHandler<GP_CLI_COMMAND_NETEND>;
    PacketSize[0x00F] = 0x00; PacketParser[0x00F] = &ValidatedPacketHandler<GP_CLI_COMMAND_CLSTAT>;
    PacketSize[0x011] = 0x00; PacketParser[0x011] = &ValidatedPacketHandler<GP_CLI_COMMAND_ZONE_TRANSITION>;
    PacketSize[0x015] = 0x10; PacketParser[0x015] = &ValidatedPacketHandler<GP_CLI_COMMAND_POS>;
    PacketSize[0x016] = 0x04; PacketParser[0x016] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHARREQ>;
    PacketSize[0x017] = 0x00; PacketParser[0x017] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHARREQ2>;
    PacketSize[0x01A] = 0x0E; PacketParser[0x01A] = &ValidatedPacketHandler<GP_CLI_COMMAND_ACTION>;
    PacketSize[0x01B] = 0x00; PacketParser[0x01B] = &ValidatedPacketHandler<GP_CLI_COMMAND_FRIENDPASS>;
    PacketSize[0x01C] = 0x00; PacketParser[0x01C] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNKNOWN>;
    PacketSize[0x01E] = 0x00; PacketParser[0x01E] = &ValidatedPacketHandler<GP_CLI_COMMAND_GM>;
    PacketSize[0x01F] = 0x00; PacketParser[0x01F] = &ValidatedPacketHandler<GP_CLI_COMMAND_GMCOMMAND>;
    PacketSize[0x028] = 0x06; PacketParser[0x028] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_DUMP>;
    PacketSize[0x029] = 0x06; PacketParser[0x029] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_MOVE>;
    PacketSize[0x02B] = 0x00; PacketParser[0x02B] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRANSLATE>;
    PacketSize[0x02C] = 0x00; PacketParser[0x02C] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEMSEARCH>;
    PacketSize[0x032] = 0x06; PacketParser[0x032] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRADE_REQ>;
    PacketSize[0x033] = 0x06; PacketParser[0x033] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRADE_RES>;
    PacketSize[0x034] = 0x06; PacketParser[0x034] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRADE_LIST>;
    PacketSize[0x036] = 0x20; PacketParser[0x036] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_TRANSFER>;
    PacketSize[0x037] = 0x0A; PacketParser[0x037] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_USE>;
    PacketSize[0x03A] = 0x04; PacketParser[0x03A] = &ValidatedPacketHandler<GP_CLI_COMMAND_ITEM_STACK>;
    PacketSize[0x03B] = 0x10; PacketParser[0x03B] = &ValidatedPacketHandler<GP_CLI_COMMAND_SUBCONTAINER>;
    PacketSize[0x03C] = 0x00; PacketParser[0x03C] = &ValidatedPacketHandler<GP_CLI_COMMAND_BLACK_LIST>;
    PacketSize[0x03D] = 0x00; PacketParser[0x03D] = &ValidatedPacketHandler<GP_CLI_COMMAND_BLACK_EDIT>;
    PacketSize[0x041] = 0x00; PacketParser[0x041] = &ValidatedPacketHandler<GP_CLI_COMMAND_TROPHY_ENTRY>;
    PacketSize[0x042] = 0x00; PacketParser[0x042] = &ValidatedPacketHandler<GP_CLI_COMMAND_TROPHY_ABSENCE>;
    PacketSize[0x04B] = 0x00; PacketParser[0x04B] = &ValidatedPacketHandler<GP_CLI_COMMAND_FRAGMENTS>;
    PacketSize[0x04D] = 0x00; PacketParser[0x04D] = &ValidatedPacketHandler<GP_CLI_COMMAND_PBX>;
    PacketSize[0x04E] = 0x1E; PacketParser[0x04E] = &ValidatedPacketHandler<GP_CLI_COMMAND_AUC>;
    PacketSize[0x050] = 0x04; PacketParser[0x050] = &ValidatedPacketHandler<GP_CLI_COMMAND_EQUIP_SET>;
    PacketSize[0x051] = 0x24; PacketParser[0x051] = &ValidatedPacketHandler<GP_CLI_COMMAND_EQUIPSET_SET>;
    PacketSize[0x052] = 0x26; PacketParser[0x052] = &ValidatedPacketHandler<GP_CLI_COMMAND_EQUIPSET_CHECK>;
    PacketSize[0x053] = 0x44; PacketParser[0x053] = &ValidatedPacketHandler<GP_CLI_COMMAND_LOCKSTYLE>;
    PacketSize[0x058] = 0x0A; PacketParser[0x058] = &ValidatedPacketHandler<GP_CLI_COMMAND_RECIPE>;
    PacketSize[0x059] = 0x00; PacketParser[0x059] = &ValidatedPacketHandler<GP_CLI_COMMAND_EFFECTEND>;
    PacketSize[0x05A] = 0x02; PacketParser[0x05A] = &ValidatedPacketHandler<GP_CLI_COMMAND_REQCONQUEST>;
    PacketSize[0x05B] = 0x0A; PacketParser[0x05B] = &ValidatedPacketHandler<GP_CLI_COMMAND_EVENTEND>;
    PacketSize[0x05C] = 0x00; PacketParser[0x05C] = &ValidatedPacketHandler<GP_CLI_COMMAND_EVENTENDXZY>;
    PacketSize[0x05D] = 0x08; PacketParser[0x05D] = &ValidatedPacketHandler<GP_CLI_COMMAND_MOTION>;
    PacketSize[0x05E] = 0x0C; PacketParser[0x05E] = &ValidatedPacketHandler<GP_CLI_COMMAND_MAPRECT>;
    PacketSize[0x060] = 0x00; PacketParser[0x060] = &ValidatedPacketHandler<GP_CLI_COMMAND_PASSWARDS>;
    PacketSize[0x061] = 0x04; PacketParser[0x061] = &ValidatedPacketHandler<GP_CLI_COMMAND_CLISTATUS>;
    PacketSize[0x063] = 0x00; PacketParser[0x063] = &ValidatedPacketHandler<GP_CLI_COMMAND_DIG>;
    PacketSize[0x064] = 0x26; PacketParser[0x064] = &ValidatedPacketHandler<GP_CLI_COMMAND_SCENARIOITEM>;
    PacketSize[0x066] = 0x0A; PacketParser[0x066] = &ValidatedPacketHandler<GP_CLI_COMMAND_FISHING>;
    PacketSize[0x06E] = 0x06; PacketParser[0x06E] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_SOLICIT_REQ>;
    PacketSize[0x06F] = 0x00; PacketParser[0x06F] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_LEAVE>;
    PacketSize[0x070] = 0x00; PacketParser[0x070] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_BREAKUP>;
    PacketSize[0x071] = 0x00; PacketParser[0x071] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_STRIKE>;
    PacketSize[0x074] = 0x00; PacketParser[0x074] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_SOLICIT_RES>;
    PacketSize[0x076] = 0x00; PacketParser[0x076] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_LIST_REQ>;
    PacketSize[0x077] = 0x00; PacketParser[0x077] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_CHANGE2>;
    PacketSize[0x078] = 0x00; PacketParser[0x078] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_CHECKID>;
    PacketSize[0x083] = 0x08; PacketParser[0x083] = &ValidatedPacketHandler<GP_CLI_COMMAND_SHOP_BUY>;
    PacketSize[0x084] = 0x06; PacketParser[0x084] = &ValidatedPacketHandler<GP_CLI_COMMAND_SHOP_SELL_REQ>;
    PacketSize[0x085] = 0x04; PacketParser[0x085] = &ValidatedPacketHandler<GP_CLI_COMMAND_SHOP_SELL_SET>;
    PacketSize[0x096] = 0x12; PacketParser[0x096] = &ValidatedPacketHandler<GP_CLI_COMMAND_COMBINE_ASK>;
    PacketSize[0x09B] = 0x00; PacketParser[0x09B] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHOCOBO_RACE_REQ>;
    PacketSize[0x0A0] = 0x00; PacketParser[0x0A0] = &ValidatedPacketHandler<GP_CLI_COMMAND_SWITCH_PROPOSAL>;
    PacketSize[0x0A1] = 0x00; PacketParser[0x0A1] = &ValidatedPacketHandler<GP_CLI_COMMAND_SWITCH_VOTE>;
    PacketSize[0x0A2] = 0x00; PacketParser[0x0A2] = &ValidatedPacketHandler<GP_CLI_COMMAND_DICE>;
    PacketSize[0x0AA] = 0x00; PacketParser[0x0AA] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_BUY>;
    PacketSize[0x0AB] = 0x00; PacketParser[0x0AB] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_BUYLIST>;
    PacketSize[0x0AC] = 0x00; PacketParser[0x0AC] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_SELL>;
    PacketSize[0x0AD] = 0x00; PacketParser[0x0AD] = &ValidatedPacketHandler<GP_CLI_COMMAND_GUILD_SELLLIST>;
    PacketSize[0x0B5] = 0x00; PacketParser[0x0B5] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHAT_STD>;
    PacketSize[0x0B6] = 0x00; PacketParser[0x0B6] = &ValidatedPacketHandler<GP_CLI_COMMAND_CHAT_NAME>;
    PacketSize[0x0B7] = 0x00; PacketParser[0x0B7] = &ValidatedPacketHandler<GP_CLI_COMMAND_ASSIST_CHANNEL>;
    PacketSize[0x0BE] = 0x00; PacketParser[0x0BE] = &ValidatedPacketHandler<GP_CLI_COMMAND_MERITS>;
    PacketSize[0x0BF] = 0x04; PacketParser[0x0BF] = &ValidatedPacketHandler<GP_CLI_COMMAND_JOB_POINTS_SPEND>;
    PacketSize[0x0C0] = 0x00; PacketParser[0x0C0] = &ValidatedPacketHandler<GP_CLI_COMMAND_JOB_POINTS_REQ>;
    PacketSize[0x0C3] = 0x00; PacketParser[0x0C3] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_COMLINK_MAKE>;
    PacketSize[0x0C4] = 0x0E; PacketParser[0x0C4] = &ValidatedPacketHandler<GP_CLI_COMMAND_GROUP_COMLINK_ACTIVE>;
    PacketSize[0x0CB] = 0x04; PacketParser[0x0CB] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_IS>;
    PacketSize[0x0D2] = 0x04; PacketParser[0x0D2] = &ValidatedPacketHandler<GP_CLI_COMMAND_MAP_GROUP>;
    PacketSize[0x0D3] = 0x00; PacketParser[0x0D3] = &ValidatedPacketHandler<GP_CLI_COMMAND_FAQ_GMCALL>;
    PacketSize[0x0D4] = 0x04; PacketParser[0x0D4] = &ValidatedPacketHandler<GP_CLI_COMMAND_FAQ_GMPARAM>;
    PacketSize[0x0D5] = 0x08; PacketParser[0x0D5] = &ValidatedPacketHandler<GP_CLI_COMMAND_ACK_GMMSG>;
    PacketSize[0x0D8] = 0x00; PacketParser[0x0D8] = &ValidatedPacketHandler<GP_CLI_COMMAND_DUNGEON_PARAM>;
    PacketSize[0x0DB] = 0x00; PacketParser[0x0DB] = &ValidatedPacketHandler<GP_CLI_COMMAND_CONFIG_LANGUAGE>;
    PacketSize[0x0DC] = 0x0A; PacketParser[0x0DC] = &ValidatedPacketHandler<GP_CLI_COMMAND_CONFIG>;
    PacketSize[0x0DD] = 0x08; PacketParser[0x0DD] = &ValidatedPacketHandler<GP_CLI_COMMAND_EQUIP_INSPECT>;
    PacketSize[0x0DE] = 0x40; PacketParser[0x0DE] = &ValidatedPacketHandler<GP_CLI_COMMAND_INSPECT_MESSAGE>;
    PacketSize[0x0E0] = 0x00; PacketParser[0x0E0] = &ValidatedPacketHandler<GP_CLI_COMMAND_SET_USERMSG>;
    PacketSize[0x0E1] = 0x00; PacketParser[0x0E1] = &ValidatedPacketHandler<GP_CLI_COMMAND_GET_LSMSG>;
    PacketSize[0x0E2] = 0x00; PacketParser[0x0E2] = &ValidatedPacketHandler<GP_CLI_COMMAND_SET_LSMSG>;
    PacketSize[0x0E4] = 0x00; PacketParser[0x0E4] = &ValidatedPacketHandler<GP_CLI_COMMAND_GET_LSPRIV>;
    PacketSize[0x0E7] = 0x04; PacketParser[0x0E7] = &ValidatedPacketHandler<GP_CLI_COMMAND_REQLOGOUT>;
    PacketSize[0x0E8] = 0x04; PacketParser[0x0E8] = &ValidatedPacketHandler<GP_CLI_COMMAND_CAMP>;
    PacketSize[0x0EA] = 0x04; PacketParser[0x0EA] = &ValidatedPacketHandler<GP_CLI_COMMAND_SIT>;
    PacketSize[0x0EB] = 0x00; PacketParser[0x0EB] = &ValidatedPacketHandler<GP_CLI_COMMAND_REQSUBMAPNUM>;
    PacketSize[0x0F0] = 0x04; PacketParser[0x0F0] = &ValidatedPacketHandler<GP_CLI_COMMAND_RESCUE>;
    PacketSize[0x0F1] = 0x04; PacketParser[0x0F1] = &ValidatedPacketHandler<GP_CLI_COMMAND_BUFFCANCEL>;
    PacketSize[0x0F2] = 0x04; PacketParser[0x0F2] = &ValidatedPacketHandler<GP_CLI_COMMAND_SUBMAPCHANGE>;
    PacketSize[0x0F4] = 0x04; PacketParser[0x0F4] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRACKING_LIST>;
    PacketSize[0x0F5] = 0x00; PacketParser[0x0F5] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRACKING_START>;
    PacketSize[0x0F6] = 0x00; PacketParser[0x0F6] = &ValidatedPacketHandler<GP_CLI_COMMAND_TRACKING_END>;
    PacketSize[0x0FA] = 0x00; PacketParser[0x0FA] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_LAYOUT>;
    PacketSize[0x0FB] = 0x00; PacketParser[0x0FB] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_BANKIN>;
    PacketSize[0x0FC] = 0x00; PacketParser[0x0FC] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_ADD>;
    PacketSize[0x0FD] = 0x00; PacketParser[0x0FD] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_CHECK>;
    PacketSize[0x0FE] = 0x00; PacketParser[0x0FE] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_CROP>;
    PacketSize[0x0FF] = 0x00; PacketParser[0x0FF] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_PLANT_STOP>;
    PacketSize[0x100] = 0x04; PacketParser[0x100] = &ValidatedPacketHandler<GP_CLI_COMMAND_MYROOM_JOB>;
    PacketSize[0x102] = 0x52; PacketParser[0x102] = &ValidatedPacketHandler<GP_CLI_COMMAND_EXTENDED_JOB>;
    PacketSize[0x104] = 0x02; PacketParser[0x104] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_EXIT>;
    PacketSize[0x105] = 0x06; PacketParser[0x105] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_LIST>;
    PacketSize[0x106] = 0x06; PacketParser[0x106] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_BUY>;
    PacketSize[0x109] = 0x00; PacketParser[0x109] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_OPEN>;
    PacketSize[0x10A] = 0x06; PacketParser[0x10A] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_ITEMSET>;
    PacketSize[0x10B] = 0x00; PacketParser[0x10B] = &ValidatedPacketHandler<GP_CLI_COMMAND_BAZAAR_CLOSE>;
    PacketSize[0x10C] = 0x04; PacketParser[0x10C] = &ValidatedPacketHandler<GP_CLI_COMMAND_ROE_START>;
    PacketSize[0x10D] = 0x04; PacketParser[0x10D] = &ValidatedPacketHandler<GP_CLI_COMMAND_ROE_REMOVE>;
    PacketSize[0x10E] = 0x04; PacketParser[0x10E] = &ValidatedPacketHandler<GP_CLI_COMMAND_ROE_CLAIM>;
    PacketSize[0x10F] = 0x02; PacketParser[0x10F] = &ValidatedPacketHandler<GP_CLI_COMMAND_CURRENCIES_1>;
    PacketSize[0x110] = 0x0A; PacketParser[0x110] = &ValidatedPacketHandler<GP_CLI_COMMAND_FISHING_2>;
    PacketSize[0x112] = 0x00; PacketParser[0x112] = &ValidatedPacketHandler<GP_CLI_COMMAND_BATTLEFIELD_REQ>;
    PacketSize[0x113] = 0x06; PacketParser[0x113] = &ValidatedPacketHandler<GP_CLI_COMMAND_SITCHAIR>;
    PacketSize[0x114] = 0x00; PacketParser[0x114] = &ValidatedPacketHandler<GP_CLI_COMMAND_MAP_MARKERS>;
    PacketSize[0x115] = 0x02; PacketParser[0x115] = &ValidatedPacketHandler<GP_CLI_COMMAND_CURRENCIES_2>;
    PacketSize[0x116] = 0x00; PacketParser[0x116] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNITY_MENU>;
    PacketSize[0x117] = 0x00; PacketParser[0x117] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNITY_QUEST>;
    PacketSize[0x118] = 0x00; PacketParser[0x118] = &ValidatedPacketHandler<GP_CLI_COMMAND_UNITY_TOGGLE>;
    PacketSize[0x119] = 0x00; PacketParser[0x119] = &ValidatedPacketHandler<GP_CLI_COMMAND_EMOTE_LIST>;
    PacketSize[0x11B] = 0x00; PacketParser[0x11B] = &ValidatedPacketHandler<GP_CLI_COMMAND_MASTERY_DISPLAY>;
    PacketSize[0x11C] = 0x08; PacketParser[0x11C] = &ValidatedPacketHandler<GP_CLI_COMMAND_PARTY_REQUEST>;
    PacketSize[0x11D] = 0x00; PacketParser[0x11D] = &ValidatedPacketHandler<GP_CLI_COMMAND_JUMP>;
    // clang-format on
}
