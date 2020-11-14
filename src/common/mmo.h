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

#include <string>
#include <time.h>
#include <stdlib.h>
#include <bitset>
#include <array>

#define FIFOSIZE_SERVERLINK	256*1024

#define FFXI_HEADER_SIZE 0x1C		// common packet header size
#define FFXI_CHANGE_ZONE 0x0A		// change zone cmd

// Flags shown in front of the character's name

enum FLAGTYPE : uint32
{
    FLAG_INEVENT        = 0x00000002,
    FLAG_CHOCOBO        = 0x00000040,
    FLAG_WALLHACK       = 0x00000200,
    FLAG_INVITE         = 0x00000800,
    FLAG_ANON           = 0x00001000,
    FLAG_UNKNOWN        = 0x00002000,
    FLAG_AWAY           = 0x00004000,
    FLAG_PLAYONLINE     = 0x00010000,
    FLAG_LINKSHELL      = 0x00020000,
    FLAG_DC             = 0x00040000,
    FLAG_GM             = 0x04000000,
    FLAG_GM_SUPPORT     = 0x04000000,
    FLAG_GM_SENIOR      = 0x05000000,
    FLAG_GM_LEAD        = 0x06000000,
    FLAG_GM_PRODUCER    = 0x07000000,
    FLAG_BAZAAR         = 0x80000000,
};

enum NFLAGTYPE : uint32
{
    NFLAG_INVITE        = 0x00000001,
    NFLAG_AWAY          = 0x00000002,
    NFLAG_ANON          = 0x00000004,
    NFLAG_AUTOTARGET    = 0x00004000,
    NFLAG_AUTOGROUP     = 0x00008000,
    NFLAG_MENTOR        = 0x02000000,
    NFLAG_NEWPLAYER     = 0x04000000,
    NFLAG_DISPLAY_HEAD  = 0x08000000,
    NFLAG_RECRUIT       = 0x20000000,
};

enum MSGSERVTYPE : uint8
{
    MSG_LOGIN,
    MSG_CHAT_TELL,
    MSG_CHAT_PARTY,
    MSG_CHAT_LINKSHELL,
    MSG_CHAT_YELL,
    MSG_CHAT_SERVMES,
    MSG_PT_INVITE,
    MSG_PT_INV_RES,
    MSG_PT_RELOAD,
    MSG_PT_DISBAND,
    MSG_DIRECT,
    MSG_LINKSHELL_RANK_CHANGE,
    MSG_LINKSHELL_REMOVE,

    // gm commands
    MSG_SEND_TO_ZONE,
    MSG_SEND_TO_ENTITY,
};

typedef std::string string_t;

// For characters, the size is stored in `size`.
// For NPCs and monsters, something like the type of model is stored.

struct look_t
{
	uint16 size;
    union {
        struct {
            uint8  face, race;
        };
        uint16 modelid;
    };
	uint16 head, body, hands, legs, feet, main, sub, ranged;
};

struct skills_t
{
	union {
		struct {
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
			// SkillID 44-47
			uint16 reserved2[4];
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
	// The rank is only used in crafts. A size of 64 is required for skill ID compatability.
	uint8 rank[64];
};

struct keyitems_table_t
{
    std::bitset<512> keyList;
    std::bitset<512> seenList;
};

struct keyitems_t
{
    std::array<keyitems_table_t, 7> tables;
};

struct position_t
{
    float x;
    float y;                // Entity height, relative to "sea level"
    float z;
    uint16 moving;          // Somehing like the travel distance, the number of steps required for correct rendering in the client.

    // The angle of rotation of the entity relative to its position. A maximum rotation value of
    // 255 is used as the rotation is stored in `uint8`. Use `rotationToRadian()` and
    // `radianToRotation()` util functions to convert back and forth between the 255-encoded
    // rotation value and the radian value.
    uint8 rotation;
};

struct stats_t
{
	uint16 STR,DEX,VIT,AGI,INT,MND,CHR;
};

struct questlog_t
{
	uint8 current [32];
	uint8 complete[32];
};

struct missionlog_t
{
	uint16 current;
    uint16 logExUpper;
    uint16 logExLower;
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
    uint16 active[31];   //slot 31 is for time-limited records
    uint32 progress[31];
    uint8 complete[512]; //bitmap of all 4096 possible records.
};

struct eminencecache_t
{
    std::bitset<4096> activemap;
    uint32 lastWriteout {0};
    bool notifyTimedRecord {false};
};

struct nameflags_t
{
	union {
		struct {
			uint8 byte1;
			uint8 byte2;
			uint8 byte3;
			uint8 byte4;
		};
		uint32 flags;
	};
};

// Information for the search window.
struct search_t
{
	uint8 language;			// Preferred language
	uint8 messagetype;		// Type of message

	string_t message;	//  Search message text
};

struct bazaar_t
{
	string_t message;
};

// A comment on the packets below, defined as macros.
//   byte 0 - packet size
//   bytes 4-7 are the packet header "IXFF" (0x49, 0x58, 0x46, 0x46)
//   byte 8 - The expected message type:
//     0x03 - positive result
//     0x04 - error (in the case of an error, a uint16 error code is used at byte 32)
//     Other

#define LOBBY_A1_RESERVEPACKET(a)\
unsigned char a[] = { \
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
		0x0a, 0x52, 0x03, 0x00, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x0f, 0x00, 0x00							\
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
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 \
	}

#define LOBBY_ACTION_DONE(a)\
unsigned char a[]={\
			0x20, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00\
		}

#define LOBBBY_ERROR_MESSAGE(a)\
unsigned char a[]={ \
			0x24, 0x00, 0x00, 0x00, 0x49, 0x58, 0x46, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,\
			0x00, 0x00, 0x00, 0x00\
		}

class char_mini
{
public:

	int8	m_name[16];

	uint8	m_mjob;
	uint16	m_zone;
	uint8	m_nation;

	look_t	m_look;

	 char_mini() {};
	~char_mini() {};
};

#endif // _MMO_H
