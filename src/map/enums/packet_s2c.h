/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#pragma once

#include <magic_enum/magic_enum.hpp>

// Server-to-Client packet IDs
// https://github.com/atom0s/XiPackets/tree/main/world/server
// Note: Some packets are not explicitly named in XiPackets and have been given tentative names.
enum class PacketS2C : uint16_t
{
    GP_SERV_COMMAND_PACKETCONTROL     = 0x005,
    GP_SERV_COMMAND_NARAKU            = 0x006,
    GP_SERV_COMMAND_ENTERZONE         = 0x008,
    GP_SERV_COMMAND_MESSAGE           = 0x009,
    GP_SERV_COMMAND_LOGIN             = 0x00A,
    GP_SERV_COMMAND_LOGOUT            = 0x00B,
    GP_SERV_COMMAND_CHAR_PC           = 0x00D,
    GP_SERV_COMMAND_CHAR_NPC          = 0x00E,
    GP_SERV_COMMAND_GM                = 0x012,
    GP_SERV_COMMAND_GMCOMMAND         = 0x013,
    GP_SERV_COMMAND_CHAT_STD          = 0x017,
    GP_SERV_COMMAND_JOB_INFO          = 0x01B,
    GP_SERV_COMMAND_ITEM_MAX          = 0x01C,
    GP_SERV_COMMAND_ITEM_SAME         = 0x01D,
    GP_SERV_COMMAND_ITEM_NUM          = 0x01E,
    GP_SERV_COMMAND_ITEM_LIST         = 0x01F,
    GP_SERV_COMMAND_ITEM_ATTR         = 0x020,
    GP_SERV_COMMAND_ITEM_TRADE_REQ    = 0x021,
    GP_SERV_COMMAND_ITEM_TRADE_RES    = 0x022,
    GP_SERV_COMMAND_ITEM_TRADE_LIST   = 0x023,
    GP_SERV_COMMAND_ITEM_TRADE_MYLIST = 0x025,
    GP_SERV_COMMAND_ITEM_SUBCONTAINER = 0x026,
    GP_SERV_COMMAND_TALKNUMWORK2      = 0x027,
    GP_SERV_COMMAND_BATTLE2           = 0x028,
    GP_SERV_COMMAND_BATTLE_MESSAGE    = 0x029,
    GP_SERV_COMMAND_TALKNUMWORK       = 0x02A,
    GP_SERV_COMMAND_BATTLE_MESSAGE2   = 0x02D,
    GP_SERV_COMMAND_OPENMOGMENU       = 0x02E,
    GP_SERV_COMMAND_DIG               = 0x02F,
    GP_SERV_COMMAND_EFFECT            = 0x030,
    GP_SERV_COMMAND_RECIPE            = 0x031,
    GP_SERV_COMMAND_EVENT             = 0x032,
    GP_SERV_COMMAND_EVENTSTR          = 0x033,
    GP_SERV_COMMAND_EVENTNUM          = 0x034,
    GP_SERV_COMMAND_TALKNUM           = 0x036,
    GP_SERV_COMMAND_SERVERSTATUS      = 0x037,
    GP_SERV_COMMAND_SCHEDULOR         = 0x038,
    GP_SERV_COMMAND_MAPSCHEDULOR      = 0x039,
    GP_SERV_COMMAND_MAGICSCHEDULOR    = 0x03A,
    GP_SERV_COMMAND_EVENTMES          = 0x03B,
    GP_SERV_COMMAND_SHOP_LIST         = 0x03C,
    GP_SERV_COMMAND_SHOP_SELL         = 0x03D,
    GP_SERV_COMMAND_SHOP_OPEN         = 0x03E,
    GP_SERV_COMMAND_SHOP_BUY          = 0x03F,
    GP_SERV_COMMAND_BLACK_LIST        = 0x041,
    GP_SERV_COMMAND_BLACK_EDIT        = 0x042,
    GP_SERV_COMMAND_TALKNUMNAME       = 0x043,
    GP_SERV_COMMAND_EXTENDED_JOB      = 0x044,
    GP_SERV_COMMAND_TRANSLATE         = 0x047,
    GP_SERV_COMMAND_LINK_CONCIERGE    = 0x048,
    GP_SERV_COMMAND_ITEMSEARCH        = 0x049,
    GP_SERV_COMMAND_PBX_RESULT        = 0x04B,
    GP_SERV_COMMAND_AUC               = 0x04C,
    GP_SERV_COMMAND_FRAGMENTS         = 0x04D,
    GP_SERV_COMMAND_EQUIP_CLEAR       = 0x04F,
    GP_SERV_COMMAND_EQUIP_LIST        = 0x050,
    GP_SERV_COMMAND_GRAP_LIST         = 0x051,
    GP_SERV_COMMAND_EVENTUCOFF        = 0x052,
    GP_SERV_COMMAND_SYSTEMMES         = 0x053,
    GP_SERV_COMMAND_SCENARIOITEM      = 0x055,
    GP_SERV_COMMAND_MISSION           = 0x056,
    GP_SERV_COMMAND_WEATHER           = 0x057,
    GP_SERV_COMMAND_ASSIST            = 0x058,
    GP_SERV_COMMAND_FRIENDPASS        = 0x059,
    GP_SERV_COMMAND_MOTIONMES         = 0x05A,
    GP_SERV_COMMAND_WPOS              = 0x05B,
    GP_SERV_COMMAND_PENDINGNUM        = 0x05C,
    GP_SERV_COMMAND_PENDINGSTR        = 0x05D,
    GP_SERV_COMMAND_CONQUEST          = 0x05E,
    GP_SERV_COMMAND_MUSIC             = 0x05F,
    GP_SERV_COMMAND_MUSICVOLUME       = 0x060,
    GP_SERV_COMMAND_CLISTATUS         = 0x061,
    GP_SERV_COMMAND_CLISTATUS2        = 0x062,
    GP_SERV_COMMAND_MISCDATA          = 0x063,
    GP_SERV_COMMAND_WPOS2             = 0x065,
    GP_SERV_COMMAND_ENTITY_UPDATE1    = 0x067,
    GP_SERV_COMMAND_ENTITY_UPDATE2    = 0x068,
    GP_SERV_COMMAND_CHOCOBO_RACING    = 0x069,
    GP_SERV_COMMAND_COMBINE_ANS       = 0x06F,
    GP_SERV_COMMAND_COMBINE_INF       = 0x070,
    GP_SERV_COMMAND_REGIONAL_CONTROL  = 0x071,
    GP_SERV_COMMAND_UNKNOWN_072       = 0x072,
    GP_SERV_COMMAND_UNKNOWN_073       = 0x073,
    GP_SERV_COMMAND_UNKNOWN_074       = 0x074,
    GP_SERV_COMMAND_BATTLEFIELD       = 0x075,
    GP_SERV_COMMAND_GROUP_EFFECTS     = 0x076,
    GP_SERV_COMMAND_ENTITY_VIS        = 0x077,
    GP_SERV_COMMAND_SWITCH_START      = 0x078,
    GP_SERV_COMMAND_SWITCH_PROC       = 0x079,
    GP_SERV_COMMAND_UNKNOWN_081       = 0x081,
    GP_SERV_COMMAND_GUILD_BUY         = 0x082,
    GP_SERV_COMMAND_GUILD_BUYLIST     = 0x083,
    GP_SERV_COMMAND_GUILD_SELL        = 0x084,
    GP_SERV_COMMAND_GUILD_SELLLIST    = 0x085,
    GP_SERV_COMMAND_GUILD_OPEN        = 0x086,
    GP_SERV_COMMAND_MERIT             = 0x08C,
    GP_SERV_COMMAND_JOB_POINTS        = 0x08D,
    GP_SERV_COMMAND_MYROOM_ENTER      = 0x096,
    GP_SERV_COMMAND_MYROOM_EXIT       = 0x097,
    GP_SERV_COMMAND_MAP_GROUP         = 0x0A0,
    GP_SERV_COMMAND_MAGIC_DATA        = 0x0AA,
    GP_SERV_COMMAND_FEAT_DATA         = 0x0AB,
    GP_SERV_COMMAND_COMMAND_DATA      = 0x0AC,
    GP_SERV_COMMAND_DUNGEON           = 0x0AD,
    GP_SERV_COMMAND_MOUNT_DATA        = 0x0AE,
    GP_SERV_COMMAND_CONFIG            = 0x0B4,
    GP_SERV_COMMAND_FAQ_GMPARAM       = 0x0B5,
    GP_SERV_COMMAND_SET_GMMSG         = 0x0B6,
    GP_SERV_COMMAND_GMSCITEM          = 0x0B7,
    GP_SERV_COMMAND_REGISTRATION      = 0x0BF,
    GP_SERV_COMMAND_GROUP_TBL         = 0x0C8,
    GP_SERV_COMMAND_EQUIP_INSPECT     = 0x0C9,
    GP_SERV_COMMAND_INSPECT_MESSAGE   = 0x0CA,
    GP_SERV_COMMAND_LINKSHELL_MESSAGE = 0x0CC,
    GP_SERV_COMMAND_TROPHY_LIST       = 0x0D2,
    GP_SERV_COMMAND_TROPHY_SOLUTION   = 0x0D3,
    GP_SERV_COMMAND_GROUP_SOLICIT_REQ = 0x0DC,
    GP_SERV_COMMAND_GROUP_LIST        = 0x0DD,
    GP_SERV_COMMAND_GROUP_SOLICIT_NO  = 0x0DE,
    GP_SERV_COMMAND_GROUP_ATTR        = 0x0DF,
    GP_SERV_COMMAND_GROUP_COMLINK     = 0x0E0,
    GP_SERV_COMMAND_GROUP_CHECKID     = 0x0E1,
    GP_SERV_COMMAND_GROUP_LIST2       = 0x0E2,
    GP_SERV_COMMAND_BALLISTA          = 0x0E6,
    GP_SERV_COMMAND_TRACKING_LIST     = 0x0F4,
    GP_SERV_COMMAND_TRACKING_POS      = 0x0F5,
    GP_SERV_COMMAND_TRACKING_STATE    = 0x0F6,
    GP_SERV_COMMAND_RES               = 0x0F9,
    GP_SERV_COMMAND_MYROOM_OPERATION  = 0x0FA,
    GP_SERV_COMMAND_BAZAAR_LIST       = 0x105,
    GP_SERV_COMMAND_BAZAAR_BUY        = 0x106,
    GP_SERV_COMMAND_BAZAAR_CLOSE      = 0x107,
    GP_SERV_COMMAND_BAZAAR_SHOPPING   = 0x108,
    GP_SERV_COMMAND_BAZAAR_SELL       = 0x109,
    GP_SERV_COMMAND_BAZAAR_SALE       = 0x10A,
    GP_SERV_COMMAND_REQSUBMAPNUM      = 0x10E,
    GP_SERV_COMMAND_UNITY             = 0x110,
    GP_SERV_COMMAND_ROE_ACTIVELOG     = 0x111,
    GP_SERV_COMMAND_ROE_LOG           = 0x112,
    GP_SERV_COMMAND_CURRENCIES_1      = 0x113,
    GP_SERV_COMMAND_FISH              = 0x115,
    GP_SERV_COMMAND_EQUIPSET_VALID    = 0x116,
    GP_SERV_COMMAND_EQUIPSET_RES      = 0x117,
    GP_SERV_COMMAND_CURRENCIES_2      = 0x118,
    GP_SERV_COMMAND_ABIL_RECAST       = 0x119,
    GP_SERV_COMMAND_EMOTELIST         = 0x11A,
    GP_SERV_COMMAND_PARTYREQ          = 0x11D,
    GP_SERV_COMMAND_JUMP              = 0x11E,
};

template <>
struct magic_enum::customize::enum_range<PacketS2C>
{
    static constexpr int min = 0;
    static constexpr int max = 300;
};
