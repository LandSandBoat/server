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

#ifndef _MMO_H
#define _MMO_H

#include "cbasetypes.h"

#include <array>
#include <bitset>
#include <stdlib.h>
#include <string>
#include <time.h>

#define FIFOSIZE_SERVERLINK 256 * 1024

#define FFXI_HEADER_SIZE 0x1C // common packet header size
#define FFXI_CHANGE_ZONE 0x0A // change zone cmd

// Flags shown in front of the character's name

enum FLAGTYPE : uint32
{
    FLAG_INEVENT     = 0x00000002,
    FLAG_CHOCOBO     = 0x00000040,
    FLAG_WALLHACK    = 0x00000200,
    FLAG_INVITE      = 0x00000800,
    FLAG_ANON        = 0x00001000,
    FLAG_UNKNOWN     = 0x00002000,
    FLAG_AWAY        = 0x00004000,
    FLAG_PLAYONLINE  = 0x00010000,
    FLAG_LINKSHELL   = 0x00020000,
    FLAG_DC          = 0x00040000,
    FLAG_GM          = 0x04000000,
    FLAG_GM_SUPPORT  = 0x04000000,
    FLAG_GM_SENIOR   = 0x05000000,
    FLAG_GM_LEAD     = 0x06000000,
    FLAG_GM_PRODUCER = 0x07000000,
    FLAG_BAZAAR      = 0x80000000,
};
DECLARE_FORMAT_AS_UNDERLYING(FLAGTYPE);

enum NFLAGTYPE : uint32
{
    NFLAG_INVITE          = 0x00000001,
    NFLAG_AWAY            = 0x00000002,
    NFLAG_ANON            = 0x00000004,
    NFLAG_SYSTEM_FILTER_L = 0x00000800,
    NFLAG_SYSTEM_FILTER_H = 0x00001000,
    NFLAG_AUTOTARGET      = 0x00004000,
    NFLAG_AUTOGROUP       = 0x00008000,
    NFLAG_MENTOR          = 0x02000000,
    NFLAG_NEWPLAYER       = 0x04000000,
    NFLAG_DISPLAY_HEAD    = 0x08000000,
    NFLAG_RECRUIT         = 0x20000000,
};
DECLARE_FORMAT_AS_UNDERLYING(NFLAGTYPE);

enum CHATFILTERTYPE : uint64
{
    CHATFILTER_SAY         = 0x00000000000001,
    CHATFILTER_ASSIST_J    = 0x08000000000000,
    CHATFILTER_ASSIST_E    = 0x10000000000000,
    CHATFILTER_EMOTES      = 0x00000000000008,
    CHATFILTER_SHOUT       = 0x00000000000002,
    CHATFILTER_YELL        = 0x01000000000000,
    CHATFILTER_BATTLE0     = 0x00000000000010,
    CHATFILTER_BATTLE1     = 0x00000000000020,
    CHATFILTER_BATTLE2     = 0x00000000000040,
    CHATFILTER_BATTLE3     = 0x00000000000080,
    CHATFILTER_BATTLE4     = 0x00000000000100,
    CHATFILTER_BATTLE5     = 0x00000000000200,
    CHATFILTER_BATTLE6     = 0x00000000800000,
    CHATFILTER_BATTLE7     = 0x00000000002000,
    CHATFILTER_BATTLE8     = 0x00000000004000,
    CHATFILTER_BATTLE9     = 0x00000000008000,
    CHATFILTER_BATTLE10    = 0x00000000010000,
    CHATFILTER_BATTLE11    = 0x00000000020000,
    CHATFILTER_BATTLE12    = 0x00000001000000,
    CHATFILTER_BATTLE13    = 0x00000000040000,
    CHATFILTER_BATTLE14    = 0x00000000080000,
    CHATFILTER_BATTLE15    = 0x00000000100000,
    CHATFILTER_BATTLE16    = 0x00000000200000,
    CHATFILTER_BATTLE17    = 0x00000000400000,
    CHATFILTER_BATTLE18    = 0x00020000000000,
    CHATFILTER_BATTLE19    = 0x00010000000000,
    CHATFILTER_BATTLE20    = 0x00001000000000,
    CHATFILTER_BATTLE21    = 0x00002000000000,
    CHATFILTER_BATTLE22    = 0x00004000000000,
    CHATFILTER_BATTLE23    = 0x00008000000000,
    CHATFILTER_BATTLE24    = 0x00000800000000,
    CHATFILTER_BATTLE25    = 0x00000400000000,
    CHATFILTER_BATTLE26    = 0x00000010000000,
    CHATFILTER_BATTLE27    = 0x00000020000000,
    CHATFILTER_BATTLE28    = 0x00000100000000,
    CHATFILTER_BATTLE29    = 0x00000200000000,
    CHATFILTER_BATTLE30    = 0x00000002000000,
    CHATFILTER_BATTLE31    = 0x00000000000400,
    CHATFILTER_BATTLE32    = 0x00000000000800,
    CHATFILTER_BATTLE33    = 0x00000000001000,
    CHATFILTER_SYNTHESIS   = 0x00000004000000,
    CHATFILTER_LOT_RESULTS = 0x00000008000000,
    CHATFILTER_CAMPAIGN    = 0x00040000000000,
    CHATFILTER_TELL_SPAM   = 0x00080000000000,
    CHATFILTER_YELL_SPAM   = 0x00100000000000,
    CHATFILTER_JOBEMOTE    = 0x00800000000000,
    CHATFILTER_ALTEREGO    = 0x02000000000000,
    // System message filters are
    // NFLAG_SYSTEM_FILTER_L
    // NFLAG_SYSTEM_FILTER_H
    // Filter level is 0-3
};
DECLARE_FORMAT_AS_UNDERLYING(CHATFILTERTYPE);

enum MSGSERVTYPE : uint8
{
    MSG_LOGIN,
    MSG_CHAT_TELL,
    MSG_CHAT_PARTY,
    MSG_CHAT_ALLIANCE,
    MSG_CHAT_LINKSHELL,
    MSG_CHAT_UNITY,
    MSG_CHAT_YELL,
    MSG_CHAT_SERVMES,
    MSG_PT_INVITE,
    MSG_PT_INV_RES,
    MSG_PT_RELOAD,
    MSG_PT_DISBAND,
    MSG_ALLIANCE_RELOAD,
    MSG_ALLIANCE_DISSOLVE,
    MSG_PLAYER_KICK,
    MSG_DIRECT,
    MSG_LINKSHELL_RANK_CHANGE,
    MSG_LINKSHELL_REMOVE,
    MSG_LUA_FUNCTION,
    MSG_CHARVAR_UPDATE,

    // conquest, besieged, campaign..
    MSG_WORLD2MAP_REGIONAL_EVENT,
    MSG_MAP2WORLD_REGIONAL_EVENT,

    // gm commands
    MSG_SEND_TO_ZONE,
    MSG_SEND_TO_ENTITY,

    // rpc
    MSG_RPC_SEND, // sent by sender -> reciever
    MSG_RPC_RECV, // sent by reciever -> sender
};
DECLARE_FORMAT_AS_UNDERLYING(MSGSERVTYPE);

enum REGIONALMSGTYPE : uint8
{
    REGIONAL_EVT_MSG_CONQUEST,
    REGIONAL_EVT_MSG_BESIEGED,
    REGIONAL_EVT_MSG_CAMPAIGN,
    REGIONAL_EVT_MSG_COLONIZATION,
};
DECLARE_FORMAT_AS_UNDERLYING(REGIONALMSGTYPE);

enum CONQUESTMSGTYPE : uint8
{
    // WORLD --------> MAP

    // World map broadcasts weekly update started to all zones
    CONQUEST_WORLD2MAP_WEEKLY_UPDATE_START,
    // World map broadcasts that update is done, with the respective tally
    CONQUEST_WORLD2MAP_WEEKLY_UPDATE_END,
    // World map broadcasts influence point updates to all zones.
    // Used for periodic updates or initialization.
    CONQUEST_WORLD2MAP_INFLUENCE_POINTS,
    // World map broadcasts region control data to all zones.
    // Used for initialization.
    CONQUEST_WORLD2MAP_REGION_CONTROL,

    // MAP ----------> WORLD

    // A GM Triggers a weekly update. From one zone to world.
    // World should send CONQUEST_WORLD2MAP_WEEKLY_UPDATE_START and
    // CONQUEST_WORLD2MAP_WEEKLY_UPDATE_END when done
    CONQUEST_MAP2WORLD_GM_WEEKLY_UPDATE,
    // A GM requests houry conquest data (just influence points).
    // World server should respond with CONQUEST_WORLD2MAP_INFLUENCE_POINTS triggering a zone update
    CONQUEST_MAP2WORLD_GM_CONQUEST_UPDATE,
    // Influence point update from any zone to world.
    CONQUEST_MAP2WORLD_ADD_INFLUENCE_POINTS,
};
DECLARE_FORMAT_AS_UNDERLYING(CONQUESTMSGTYPE);

constexpr auto msgTypeToStr = [](uint8 msgtype)
{
    switch (msgtype)
    {
        case MSG_LOGIN:
            return "MSG_LOGIN";
        case MSG_CHAT_TELL:
            return "MSG_CHAT_TELL";
        case MSG_CHAT_PARTY:
            return "MSG_CHAT_PARTY";
        case MSG_CHAT_ALLIANCE:
            return "MSG_CHAT_ALLIANCE";
        case MSG_CHAT_LINKSHELL:
            return "MSG_CHAT_LINKSHELL";
        case MSG_CHAT_UNITY:
            return "MSG_CHAT_UNITY";
        case MSG_CHAT_YELL:
            return "MSG_CHAT_YELL";
        case MSG_CHAT_SERVMES:
            return "MSG_CHAT_SERVMES";
        case MSG_PT_INVITE:
            return "MSG_PT_INVITE";
        case MSG_PT_INV_RES:
            return "MSG_PT_INV_RES";
        case MSG_PT_RELOAD:
            return "MSG_PT_RELOAD";
        case MSG_PT_DISBAND:
            return "MSG_PT_DISBAND";
        case MSG_ALLIANCE_RELOAD:
            return "MSG_ALLIANCE_RELOAD";
        case MSG_ALLIANCE_DISSOLVE:
            return "MSG_ALLIANCE_DISSOLVE";
        case MSG_PLAYER_KICK:
            return "MSG_PLAYER_KICK";
        case MSG_DIRECT:
            return "MSG_DIRECT";
        case MSG_LINKSHELL_RANK_CHANGE:
            return "MSG_LINKSHELL_RANK_CHANGE";
        case MSG_LINKSHELL_REMOVE:
            return "MSG_LINKSHELL_REMOVE";
        case MSG_LUA_FUNCTION:
            return "MSG_LUA_FUNCTION";
        case MSG_CHARVAR_UPDATE:
            return "MSG_CHARVAR_UPDATE";
        case MSG_SEND_TO_ZONE:
            return "MSG_SEND_TO_ZONE";
        case MSG_SEND_TO_ENTITY:
            return "MSG_SEND_TO_ENTITY";
        case MSG_RPC_SEND:
            return "MSG_RPC_SEND";
        case MSG_RPC_RECV:
            return "MSG_RPC_RECV";
        case MSG_WORLD2MAP_REGIONAL_EVENT:
            return "MSG_WORLD2MAP_REGIONAL_EVENT";
        default:
            return "Unknown";
    };
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

    skills_t()
    {
        std::memset(&skill, 0, sizeof(skill));
        std::memset(&rank, 0, sizeof(rank));
    }
};

struct keyitems_table_t
{
    std::bitset<512> keyList;
    std::bitset<512> seenList;

    keyitems_table_t()
    {
    }
};

struct keyitems_t
{
    std::array<keyitems_table_t, 7> tables;

    keyitems_t()
    {
    }
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
        x        = 0.f;
        y        = 0.f;
        z        = 0.f;
        moving   = 0;
        rotation = 0;
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

    stats_t()
    {
        STR = 0;
        DEX = 0;
        VIT = 0;
        AGI = 0;
        INT = 0;
        MND = 0;
        CHR = 0;
    }
};

struct questlog_t
{
    uint8 current[32];
    uint8 complete[32];

    questlog_t()
    {
        std::memset(&current, 0, sizeof(current));
        std::memset(&complete, 0, sizeof(complete));
    }
};

struct missionlog_t
{
    uint16 current;
    uint16 statusUpper;
    uint16 statusLower;
    bool   complete[64];

    missionlog_t()
    {
        current     = 0;
        statusUpper = 0;
        statusLower = 0;

        std::memset(&complete, 0, sizeof(complete));
    }
};

struct assaultlog_t
{
    uint16 current;
    bool   complete[128];

    assaultlog_t()
    {
        current = 0;
        std::memset(&complete, 0, sizeof(complete));
    }
};

struct campaignlog_t
{
    uint16 current;
    bool   complete[512];

    campaignlog_t()
    {
        current = 0;
        std::memset(&complete, 0, sizeof(complete));
    }
};

struct eminencelog_t
{
    uint16 active[31]; // slot 31 is for time-limited records
    uint32 progress[31];
    uint8  complete[512]; // bitmap of all 4096 possible records.

    eminencelog_t()
    {
        std::memset(&active, 0, sizeof(active));
        std::memset(&progress, 0, sizeof(progress));
        std::memset(&complete, 0, sizeof(complete));
    }
};

struct eminencecache_t
{
    std::bitset<4096> activemap;
    uint32            lastWriteout;
    bool              notifyTimedRecord;
    ;

    eminencecache_t()
    {
        lastWriteout      = 0;
        notifyTimedRecord = false;
    }
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

    nameflags_t()
    {
        flags = 0;
    }
};

struct search_t
{
    uint8       language;
    uint8       messagetype;
    std::string message;

    search_t()
    {
        language    = 0;
        messagetype = 0;
    }
};

struct bazaar_t
{
    std::string message;

    bazaar_t()
    {
    }
};

struct pathpoint_t
{
    position_t position{};
    uint32     wait        = 0;
    bool       setRotation = false;
};

// A comment on the packets below, defined as macros.
//   byte 0 - packet size
//   bytes 4-7 are the packet header "IXFF" (0x49, 0x58, 0x46, 0x46)
//   byte 8 - The expected message type:
//     0x03 - positive result
//     0x04 - error (in the case of an error, a uint16 error code is used at byte 32)
//     Other

// clang-format off
#define LOBBY_A1_RESERVEPACKET(a)\
unsigned char a[] = { \
        0xc4, 0x01, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x20, 0x00, 0x00, 0x00, 0x2a, 0x72, 0x4a, 0x94,\
        0x4f, 0x60, 0x27, 0xc4, 0x45, 0x4b, 0x7d, 0xcf, 0x27, 0x8e, 0x6d, 0xcd, 0x03, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x61, 0x6c, 0x65, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x05, 0x00,\
        0x07, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x02, 0x00, 0x10, 0x00, 0x20, 0x00, 0x30,\
        0x00, 0x40, 0x00, 0x50, 0x00, 0x60, 0x00, 0x70, 0x00, 0x01, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00,\
        0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0xb5, 0xfa, 0x01, 0x00,\
        0x7e, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,\
        0x01, 0x01, 0x01, 0x01, 0x46, 0x6e, 0xcf, 0x09, 0xde, 0x17, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x0a, 0x52, 0x03, 0x00, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x0f, 0x00, 0x00\
}

#define LOBBY_A2_RESERVEPACKET(a)\
unsigned char a[]={ \
        0x48, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x0b, 0x00, 0x00, 0x00, 0x30, 0xD0, 0x10, 0xDC,\
        0x87, 0x64, 0x4B, 0x34, 0x72, 0x9A, 0x51, 0x23, 0x54, 0x14, 0x67, 0xF0, 0x82, 0xB2, 0xc0, 0x00,\
        0xC3, 0x57, 0x00, 0x00, 0x52, 0x65, 0x67, 0x69, 0x75, 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x01, 0xd6, 0xd3, 0x00, 0x00,\
        0x7F, 0x00, 0x00, 0x01, 0xf2, 0xd2, 0x00, 0x00\
    }

#define LOBBY_026_RESERVEPACKET(a) \
unsigned char a[]={\
        0x28, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x4f, 0xe0, 0x5d, 0xad,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00\
    }

#define LOBBY_024_RESERVEPACKET(a) \
unsigned char a[]={ \
        0x40, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x23, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00,\
        0x64, 0x00, 0x00, 0x00, 0x70, 0x58, 0x49, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00\
    }

#define LOBBY_ACTION_DONE(a)\
unsigned char a[]={\
        0x20, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00\
    }

#define LOBBBY_ERROR_MESSAGE(a)\
unsigned char a[]={\
        0x24, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
        0x00, 0x00, 0x00, 0x00\
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

    char_mini()
    {
        std::memset(&m_name, 0, sizeof(m_name));

        m_mjob   = 0;
        m_zone   = 0;
        m_nation = 0;
    };
    ~char_mini(){};
};

#endif // _MMO_H
