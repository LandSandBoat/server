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

#include "base.h"
#include "items/exdata/chocobo_card.h"
#include "sol/forward.hpp"

#include <array>
#include <vector>

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0069
// This packet is sent by the server in relation to the chocobo racing event.
// It has multiple purposes related to this event.
namespace GP_SERV_COMMAND_CHOCOBO_RACING
{

constexpr size_t kNumRacers         = 8;  // max chocobos per race
constexpr size_t kMaxSections       = 32; // animation sections per race
constexpr size_t kSectionsPerPacket = 16; // 192-byte payload / 12 bytes per section

// Pack 8 nibble values (one per chocobo) into 4 wire bytes.
void packNibbles(uint8_t out[4], const std::array<uint8_t, kNumRacers>& nibbles);

// Racing Chocobo definition
struct ChocoboParam
{
    uint8_t                    Orders : 4; // xi.chocoboRacing.order
    uint8_t                    Item : 4;   // xi.chocoboRacing.sectionEvent
    uint8_t                    padding00[3];
    Exdata::ChocoboStatByte    STR;
    Exdata::ChocoboStatByte    END;
    Exdata::ChocoboStatByte    DSC;
    Exdata::ChocoboStatByteRCP RCP;
    uint32_t                   DNA1 : 3;
    uint32_t                   DNA2 : 3;
    uint32_t                   DNA3 : 3;
    uint32_t                   Ability1 : 4;    // xi.chocoboRaising.ability
    uint32_t                   Ability2 : 4;    // xi.chocoboRaising.ability
    uint32_t                   Temperament : 3; // xi.chocoboRaising.temperament
    uint32_t                   Weather : 4;     // xi.chocoboRaising.weather
    uint32_t                   Gender : 1;      // xi.chocoboRaising.gender
    uint32_t                   Color : 3;       // xi.chocoboRaising.color
    uint32_t                   Size : 3;        // xi.chocoboRacing.jockeySize
    uint32_t                   unknown00 : 1;

    static ChocoboParam fromLua(const sol::table& data);
};

// Each racing section/keyframe can contain optional trigger/events
enum class SectionEventType : uint8_t
{
    Straining         = 0x00, // low-stamina state; byte0 = bitmask of straining birds (sweat icon)
    SpeedApple        = 0x01, // boost the user's speed
    StaminaApple      = 0x02, // regen the user's stamina
    ShadowApple       = 0x03, // brief evasion boost (dodge incoming items), very short duration
    PepperBiscuit     = 0x04, // reduce a target's speed (target in Param)
    FireBiscuit       = 0x05, // reduce a target's stamina (target in Targets)
    GysahlBomb        = 0x06, // reduce all nearby opponents' speed
    SporeBomb         = 0x07, // reduce all nearby opponents' discernment
    FairweatherFetish = 0x08, // clear the weather
    FoulweatherFrog   = 0x09, // call a rainstorm
    RaceStart         = 0x20, // section 0; byte1 = per-race start param
    Accident          = 0x21, // "feet caught in mud" incident - weather specific
};

struct SectionTrigger
{
    uint8_t          User;    // bitmask: the chocobo using the item (single bit for item events) or affected
    uint8_t          Targets; // bitmask: affected chocobos (== User for self-buffs)
    uint8_t          Param;   // extra affected bits (AoE) / type-specific parameter
    SectionEventType Type;    // event type
};

// One section of the race (32 sections per race)
// Encodes starting and end position (on an arbitrary 0-15 range), the client will interpolate the progress.
// Optional Triggers/Events can happen during section.
struct SectionParam
{
    uint8_t        From[4]; // 8 chocobo positions, section start
    uint8_t        To[4];   // section end
    SectionTrigger Trigger; // per-section event
};

// Mode=1: Updates ChocoboRacingSys.RaceParams.
// RaceParams[0] contains the weather, RaceParams[1] contains a race-specific counter 0-3
class RACINGPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, RACINGPARAMS>
{
public:
    struct PacketData
    {
        uint8_t  Mode;          // PS2: (New; did not exist.)
        uint8_t  padding00[3];  // PS2: (New; did not exist.)
        uint32_t RaceParams[2]; // PS2: (New; did not exist.)
        uint8_t  junk00[184];   // PS2: (New; did not exist.)
    };

    RACINGPARAMS(uint32_t weather, uint32_t raceCounter);
};

// Mode=2: This mode is used to update the ChocoboRacingSys.ChocoboParams data.
// This contains the definition of all chocobos involved in the race (up to 8)
class CHOCOBOPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, CHOCOBOPARAMS>
{
public:
    struct PacketData
    {
        uint8_t      Mode;                 // PS2: (New; did not exist.)
        uint8_t      ParamIndex;           // PS2: (New; did not exist.)
        uint8_t      ParamSize;            // PS2: (New; did not exist.)
        uint8_t      padding00;            // PS2: (New; did not exist.)
        ChocoboParam Chocobos[kNumRacers]; // PS2: (New; did not exist.)
        uint8_t      padding01[96];        // PS2: (New; did not exist.)
    };

    CHOCOBOPARAMS(const std::vector<ChocoboParam>& chocobos);
};

// Mode=3: This mode is used to update the ChocoboRacingSys.SectionParams data.
// SectionParams contains the entire progress of the race section-by-section, up to 16 per packet.
// A race is made of 32 packets so this packet is sent twice with ParamIndex set to 16 on the 2nd occurence.
class SECTIONPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, SECTIONPARAMS>
{
public:
    struct PacketData
    {
        uint8_t      Mode;                         // PS2: (New; did not exist.)
        uint8_t      ParamIndex;                   // PS2: (New; did not exist.)
        uint8_t      ParamSize;                    // PS2: (New; did not exist.)
        uint8_t      padding00;                    // PS2: (New; did not exist.)
        SectionParam Sections[kSectionsPerPacket]; // PS2: (New; did not exist.)
    };

    SECTIONPARAMS(uint8_t startIndex, const std::vector<SectionParam>& sections);
};

// Mode=4: This mode is used to update the ChocoboRacingSys.ResultParams data.
// This contains the final results of the race, with 2 chocobos packed per uint8
class RESULTPARAMS final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, RESULTPARAMS>
{
public:
    struct PacketData
    {
        uint8_t Mode;           // PS2: (New; did not exist.)
        uint8_t padding00;      // PS2: (New; did not exist.)
        uint8_t ParamSize;      // PS2: (New; did not exist.)
        uint8_t padding01;      // PS2: (New; did not exist.)
        uint8_t Places[4];      // packed finishing places (2 chocobos per byte)
        uint8_t padding02[188]; // pads the fixed 0xC8 payload
    };

    RESULTPARAMS(const std::array<uint8_t, kNumRacers>& places);
};

// Mode=5: The client ignores all data in the packet and will only set the ChocoboRacingSys.DownloadFlg to 1
// This notifies the client the entirety of the race has been received.
class END final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CHOCOBO_RACING, END>
{
public:
    struct PacketData
    {
        uint8_t Mode;           // PS2: (New; did not exist.)
        uint8_t padding00[195]; // PS2: (New; did not exist.)
    };

    END();
};

} // namespace GP_SERV_COMMAND_CHOCOBO_RACING
