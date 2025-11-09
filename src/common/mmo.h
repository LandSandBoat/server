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

#pragma once

#include "cbasetypes.h"
#include "timer.h"
#include "xi.h"

#include <array>
#include <bitset>
#include <cstdlib>
#include <cstring>
#include <string>

#define FFXI_HEADER_SIZE 0x1C // common packet header size

// For filters1_t, filters2_t and SAVE_CONF:
// See https://github.com/atom0s/XiPackets/tree/main/world/server/0x00B4
struct filters1_t
{
    uint32_t say : 1;
    uint32_t shout : 1;
    uint32_t unused02 : 1;
    uint32_t emotes : 1;
    uint32_t special_actions_started_on_by_you : 1;
    uint32_t special_action_effects_on_by_you : 1;
    uint32_t attacks_by_you : 1;
    uint32_t missed_attacks_by_you : 1;
    uint32_t attacks_you_evade : 1;
    uint32_t damage_you_take : 1;
    uint32_t special_action_effects_on_by_npcs : 1;
    uint32_t attacks_by_npcs : 1;
    uint32_t missed_attacks_by_npcs : 1;
    uint32_t special_action_effects_on_by_party : 1;
    uint32_t attacks_by_party : 1;
    uint32_t missed_attacks_by_party : 1;
    uint32_t attacks_evaded_by_party : 1;
    uint32_t damage_taken_by_party : 1;
    uint32_t special_action_effects_on_by_allies : 1;
    uint32_t attacks_by_allies : 1;
    uint32_t missed_attacks_by_allies : 1;
    uint32_t attacks_evaded_by_allies : 1;
    uint32_t damage_taken_by_allies : 1;
    uint32_t special_actions_started_on_by_party : 1;
    uint32_t special_actions_started_on_by_allies : 1;
    uint32_t special_actions_started_on_by_npcs : 1;
    uint32_t others_synthesis_and_fishing_results : 1;
    uint32_t lot_results : 1;
    uint32_t attacks_by_others : 1;
    uint32_t missed_attacks_by_others : 1;
    uint32_t unused30 : 1;
    uint32_t unused31 : 1;
};

struct filters2_t
{
    uint32_t attacks_evaded_by_others : 1;
    uint32_t damage_taken_by_others : 1;
    uint32_t special_action_effects_on_by_others : 1;
    uint32_t special_actions_started_on_by_others : 1;
    uint32_t attacks_by_foes : 1;
    uint32_t missed_attacks_by_foes : 1;
    uint32_t attacks_evaded_by_foes : 1;
    uint32_t damage_taken_by_foes : 1;
    uint32_t special_action_effects_on_by_foes : 1;
    uint32_t special_actions_started_on_by_foes : 1;
    uint32_t campaign_related_data : 1;
    uint32_t tell_messages_deemed_spam : 1;
    uint32_t shout_yell_messages_deemed_spam : 1;
    uint32_t unused13 : 1;
    uint32_t unused14 : 1;
    uint32_t job_specific_emote : 1;
    uint32_t yell : 1;
    uint32_t messages_from_alter_egos : 1;
    uint32_t unused18 : 1;
    uint32_t assist_j : 1;
    uint32_t assist_e : 1;
    uint32_t unused21 : 1;
    uint32_t unused22 : 1;
    uint32_t unused23 : 1;
    uint32_t unused24 : 1;
    uint32_t unused25 : 1;
    uint32_t unused26 : 1;
    uint32_t unused27 : 1;
    uint32_t unused28 : 1;
    uint32_t unused29 : 1;
    uint32_t unused30 : 1;
    uint32_t unused31 : 1;
};

#pragma pack(push, 1)
struct SAVE_CONF
{
    uint8_t InviteFlg : 1;
    uint8_t AwayFlg : 1;
    uint8_t AnonymityFlg : 1;
    uint8_t Language : 2;
    uint8_t unknown05 : 3;

    uint8_t unknown08 : 1;
    uint8_t unknown09 : 1;
    uint8_t unknown10 : 1;
    uint8_t SysMesFilterLevel : 2;
    uint8_t unknown13 : 1;
    uint8_t AutoTargetOffFlg : 1;
    uint8_t AutoPartyFlg : 1;

    uint8_t unknown16 : 8;

    uint8_t MentorUnlockedFlg : 1;
    uint8_t MentorFlg : 1;
    uint8_t NewAdventurerOffFlg : 1;
    uint8_t DisplayHeadOffFlg : 1;
    uint8_t unknown28 : 1;
    uint8_t RecruitFlg : 1;
    uint8_t unused : 2;

    filters1_t MessageFilter;
    filters2_t MessageFilter2;
    uint16_t   PvpFlg;
    uint8_t    AreaCode;
};
#pragma pack(pop)

struct languages_t
{
    uint8_t Japanese : 1;
    uint8_t English : 1;
    uint8_t German : 1;
    uint8_t French : 1;
    uint8_t Other : 1;
    uint8_t unused : 3;
};

// For characters, the size is stored in `size`.
// For NPCs and monsters, something like the type of model is stored.

struct look_t
{
    uint16 size;
    union
    {
        struct
        {
            uint8 face, race;
        };
        uint16 modelid;
    };
    uint16 head, body, hands, legs, feet, main, sub, ranged;

    look_t()
    {
        size    = 0;
        modelid = 0;
        head    = 0;
        body    = 0;
        hands   = 0;
        legs    = 0;
        feet    = 0;
        main    = 0;
        sub     = 0;
        ranged  = 0;
    }

    look_t(uint16 look[10])
    {
        size    = look[0];
        modelid = look[1];
        head    = look[2];
        body    = look[3];
        hands   = look[4];
        legs    = look[5];
        feet    = look[6];
        main    = look[7];
        sub     = look[8];
        ranged  = look[9];
    }
};

struct skills_t
{
    union
    {
        struct
        {
            // SkillID 0
            uint16 unknown1;
            // SkillID  1-12
            uint16 h2h, dagger, sword, gsword, axe, gaxe, scythe, polearm, katana, gkatana, club, staff;
            // SkillID 13-21
            uint16 reserved1[9];
            // SkillID 22-24
            uint16 automaton_melee, automaton_ranged, automaton_magic;
            // SkillID 25-33
            uint16 archery, marksmanship, throwing, guarding, evasion, shield, parrying, divine, healing;
            // SkillID 34-43
            uint16 enhancing, enfeebling, elemental, dark, summoning, ninjutsu, singing, string, wind, blue;
            // SkillID 45-46
            uint16 geomancy, handbell;
            // SkillID 46-47
            uint16 reserved2[2];
            // SkillID 48-54
            uint16 fishing, woodworking, smithing, goldsmithing, clothcraft, leathercraft, bonecraft;
            // SkillID 55-58
            uint16 alchemy, cooking, synergy, riding;
            // SkillID 59-62
            uint16 reserved3[4];
            // SkillID 63
            uint16 unknown2;
        };
        // index SkillID 0-63
        uint16 skill[64];
    };
    // Rank is used for crafts and loads main job or sub job skill rank, prioritizing main job skill rank.
    uint8 rank[64];
};

struct keyitems_table_t
{
    xi::bitset<512> keyList;
    xi::bitset<512> seenList;
};

struct keyitems_t
{
    std::array<keyitems_table_t, 7> tables;
};

struct position_t
{
    float  x      = 0.0f;
    float  y      = 0.0f; // Entity height, relative to "sea level"
    float  z      = 0.0f;
    uint16 moving = 0; // Something like the travel distance, the number of steps required for correct rendering in the client.

    // The angle of rotation of the entity relative to its position. A maximum rotation value of
    // 255 is used as the rotation is stored in `uint8`. Use `rotationToRadian()` and
    // `radianToRotation()` util functions to convert back and forth between the 255-encoded
    // rotation value and the radian value.
    uint8 rotation = 0;

    position_t()
    {
    }

    position_t(float _x, float _y, float _z, uint16 _moving, uint8 _rotation)
    : x(_x)
    , y(_y)
    , z(_z)
    , moving(_moving)
    , rotation(_rotation)
    {
    }
};

struct stats_t
{
    uint16 STR;
    uint16 DEX;
    uint16 VIT;
    uint16 AGI;
    uint16 INT;
    uint16 MND;
    uint16 CHR;
};

struct questlog_t
{
    uint8 current[32];
    uint8 complete[32];
};

struct missionlog_t
{
    uint16 current;
    uint16 statusUpper;
    uint16 statusLower;
    bool   complete[64];
};

struct assaultlog_t
{
    uint16 current;
    bool   complete[128];
};

struct campaignlog_t
{
    uint16 current;
    bool   complete[512];
};

struct eminencelog_t
{
    uint16 active[31]; // slot 31 is for time-limited records
    uint32 progress[31];
    uint8  complete[512]; // bitmap of all 4096 possible records.
};

struct eminencecache_t
{
    xi::bitset<4096>  activemap;
    timer::time_point lastWriteout;
    bool              notifyTimedRecord;
};

struct nameflags_t
{
    union
    {
        struct
        {
            uint8 byte1;
            uint8 byte2;
            uint8 byte3;
            uint8 byte4;
        };
        uint32 flags;
    };
};

struct search_t
{
    uint8       language;
    uint8       messagetype;
    std::string message;
};

struct bazaar_t
{
    std::string message;
};

struct pathpoint_t
{
    position_t      position;
    timer::duration wait;
    bool            setRotation;
};

// A comment on the packets below, defined as macros.
//   byte 0 - packet size
//   bytes 4-7 are the packet header "IXFF" (0x49, 0x58, 0x46, 0x46)
//   byte 8 - The expected message type:
//     0x03 - positive result
//     0x04 - error (in the case of an error, a uint16 error code is used at byte 32)
//     Other

// clang-format off
#define LOBBY_A1_RESERVEPACKET(a)                                                                       \
    unsigned char a[] = {                                                                               \
        0xc4, 0x01, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x20, 0x00, 0x00, 0x00, 0x2a, 0x72, 0x4a, 0x94, \
        0x4f, 0x60, 0x27, 0xc4, 0x45, 0x4b, 0x7d, 0xcf, 0x27, 0x8e, 0x6d, 0xcd, 0x03, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x61, 0x6c, 0x65, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x05, 0x00, \
        0x07, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x02, 0x00, 0x10, 0x00, 0x20, 0x00, 0x30, \
        0x00, 0x40, 0x00, 0x50, 0x00, 0x60, 0x00, 0x70, 0x00, 0x01, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, \
        0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0xb5, 0xfa, 0x01, 0x00, \
        0x7e, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, \
        0x01, 0x01, 0x01, 0x01, 0x46, 0x6e, 0xcf, 0x09, 0xde, 0x17, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x0a, 0x52, 0x03, 0x00, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x0f, 0x00, 0x00                          \
    }

#define LOBBY_A2_RESERVEPACKET(a)                                                                       \
    unsigned char a[] = {                                                                               \
        0x48, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x0b, 0x00, 0x00, 0x00, 0x30, 0xD0, 0x10, 0xDC, \
        0x87, 0x64, 0x4B, 0x34, 0x72, 0x9A, 0x51, 0x23, 0x54, 0x14, 0x67, 0xF0, 0x82, 0xB2, 0xc0, 0x00, \
        0xC3, 0x57, 0x00, 0x00, 0x52, 0x65, 0x67, 0x69, 0x75, 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x01, 0xd6, 0xd3, 0x00, 0x00, \
        0x7F, 0x00, 0x00, 0x01, 0xf2, 0xd2, 0x00, 0x00                                                  \
    }

#define LOBBY_026_RESERVEPACKET(a)                                                                      \
    unsigned char a[] = {                                                                               \
        0x28, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4f, 0xe0, 0x5d, 0xad, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00                                                  \
    }

#define LOBBY_024_RESERVEPACKET(a)                                                                      \
    unsigned char a[] = {                                                                               \
        0x40, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x23, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, \
        0x64, 0x00, 0x00, 0x00, 0x70, 0x58, 0x49, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  \
    }

#define LOBBY_ACTION_DONE(a)                                                                            \
    unsigned char a[] = {                                                                               \
        0x20, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  \
    }

#define LOBBBY_ERROR_MESSAGE(a)                                                                         \
    unsigned char a[] = {                                                                               \
        0x24, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
        0x00, 0x00, 0x00, 0x00                                                                          \
    }
// clang-format on

class char_mini
{
public:
    int8 m_name[16];

    uint8  m_mjob;
    uint16 m_zone;
    uint8  m_nation;

    look_t m_look;
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x000A
// Defined here for use in both map.cpp and packet_system.cpp
struct GP_CLI_LOGIN
{
    uint16_t id : 9;
    uint16_t size : 7;
    uint16_t sync;
    uint8_t  LoginPacketCheck; // PS2: LoginPacketCheck
    uint8_t  padding00;        // PS2: dam__
    uint16_t unknown00;        // PS2: MyPort
    uint32_t unknown01;        // PS2: MyIP
    uint32_t UniqueNo;         // PS2: UniqueNo
    uint16_t GrapIDTbl[9];     // PS2: GrapIDTbl
    char     sName[15];        // PS2: sName
    char     sAccunt[15];      // PS2: sAccunt
    uint8_t  Ticket[16];       // PS2: Ticket
    uint32_t Ver;              // PS2: Ver
    uint8_t  sPlatform[4];     // PS2: sPlatform
    uint16_t uCliLang;         // PS2: uCliLang
    uint16_t dammyArea;        // PS2: dammyArea
};
