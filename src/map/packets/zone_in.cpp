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

#include "zone_in.h"

#include "common/vana_time.h"

#include "entities/charentity.h"
#include "utils/zoneutils.h"

#include "instance.h"
#include "status_effect_container.h"
#include "zone.h"

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x000A

// PS2: GP_SERV_POS_HEAD
struct GP_SERV_POS_HEAD
{
    uint32_t UniqueNo;      // PS2: UniqueNo
    uint16_t ActIndex;      // PS2: ActIndex
    uint8_t  padding00;     // PS2: (Removed; was SendFlg.)
    int8_t   dir;           // PS2: dir
    float    x;             // PS2: x
    float    z;             // PS2: y
    float    y;             // PS2: z
    uint32_t flags1;        // PS2: (Multiple fields; bits.)
    uint8_t  Speed;         // PS2: Speed
    uint8_t  SpeedBase;     // PS2: SpeedBase
    uint8_t  HpMax;         // PS2: HpMax
    uint8_t  server_status; // PS2: server_status
    uint32_t flags2;        // PS2: (Multiple fields; bits.)
    uint32_t flags3;        // PS2: (Multiple fields; bits.)
    uint32_t flags4;        // PS2: (Multiple fields; bits.)
    uint32_t BtTargetID;    // PS2: BtTargetID
};

// PS2: SAVE_LOGIN_STATE
enum class SAVE_LOGIN_STATE : uint8 // Originally uint32_t, but changed to uint8 to appease Clang
{
    SAVE_LOGIN_STATE_NONE           = 0,
    SAVE_LOGIN_STATE_MYROOM         = 1,
    SAVE_LOGIN_STATE_GAME           = 2,
    SAVE_LOGIN_STATE_POLEXIT        = 3,
    SAVE_LOGIN_STATE_JOBEXIT        = 4,
    SAVE_LOGIN_STATE_POLEXIT_MYROOM = 5,
    SAVE_LOGIN_STATE_END            = 6
};

// PS2: GP_MYROOM_DANCER
struct GP_MYROOM_DANCER_PKT
{
    uint16_t mon_no;       // PS2: mon_no
    uint16_t face_no;      // PS2: face_no
    uint8_t  mjob_no;      // PS2: mjob_no
    uint8_t  hair_no;      // PS2: hair_no
    uint8_t  size;         // PS2: size
    uint8_t  sjob_no;      // PS2: sjob_no
    uint32_t get_job_flag; // PS2: get_job_flag
    int8_t   job_lev[16];  // PS2: job_lev
    uint16_t bp_base[7];   // PS2: bp_base
    int16_t  bp_adj[7];    // PS2: bp_adj
    int32_t  hpmax;        // PS2: hpmax
    int32_t  mpmax;        // PS2: mpmax
    uint8_t  sjobflg;      // PS2: sjobflg
    uint8_t  unknown00[3]; // Unknown
};

// PS2: SAVE_CONF
// Seems to be a truncated version of SAVE_CONF missing PvpFlg and AreaCode?
struct SAVE_CONF_PKT
{
    uint32_t unknown00[3]; // PS2: (Multiple fields; bits.)
};

// PS2: GP_SERV_LOGIN
struct GP_SERV_LOGIN
{
    uint16_t             id : 9;
    uint16_t             size : 7;
    uint16_t             sync;
    GP_SERV_POS_HEAD     PosHead;            // PS2: PosHead
    uint32_t             ZoneNo;             // PS2: ZoneNo
    uint32_t             ntTime;             // PS2: ntTime
    uint32_t             ntTimeSec;          // PS2: ntTimeSec
    uint32_t             GameTime;           // PS2: GameTime
    uint16_t             EventNo;            // PS2: EventNo
    uint16_t             MapNumber;          // PS2: MapNumber
    uint16_t             GrapIDTbl[9];       // PS2: GrapIDTbl
    uint16_t             MusicNum[5];        // PS2: MusicNum
    uint16_t             SubMapNumber;       // PS2: SubMapNumber
    uint16_t             EventNum;           // PS2: EventNum
    uint16_t             EventPara;          // PS2: EventPara
    uint16_t             EventMode;          // PS2: EventMode
    uint16_t             WeatherNumber;      // PS2: WeatherNumber
    uint16_t             WeatherNumber2;     // PS2: WeatherNumber2
    uint32_t             WeatherTime;        // PS2: WeatherTime
    uint32_t             WeatherTime2;       // PS2: WeatherTime2
    uint32_t             WeatherOffsetTime;  // PS2: WeatherOffsetTime
    uint32_t             ShipStart;          // PS2: ShipStart
    uint16_t             ShipEnd;            // PS2: ShipEnd
    uint16_t             IsMonstrosity;      // PS2: (New; did not exist.)
    SAVE_LOGIN_STATE     LoginState;         // PS2: LoginState
    char                 name[16];           // PS2: name
    int32_t              certificate[2];     // PS2: certificate
    uint16_t             unknown00;          // Unknown
    uint16_t             ZoneSubNo;          // PS2: (New; did not exist.)
    uint32_t             PlayTime;           // PS2: PlayTime
    uint32_t             DeadCounter;        // PS2: DeadCounter
    uint8_t              MyroomSubMapNumber; // PS2: (New; did not exist.)
    uint8_t              unknown01;          // Unknown
    uint16_t             MyroomMapNumber;    // PS2: MyroomMapNumber
    uint16_t             SendCount;          // PS2: SendCount
    uint8_t              MyRoomExitBit;      // PS2: MyRoomExitBit
    uint8_t              MogZoneFlag;        // PS2: MogZoneFlag
    GP_MYROOM_DANCER_PKT Dancer;             // PS2: Dancer
    SAVE_CONF_PKT        ConfData;           // PS2: ConfData
    uint32_t             Ex;                 // PS2: (New; did not exist.)
};

// Returns the Model ID of the mog house to be used
// This is not the same as the actual Zone ID!
// (These used to be entries in the ZONEID enum, but that was wrong, knowing what we know now)
uint16 GetMogHouseModelID(CCharEntity* PChar)
{
    // Shift right 7 places, mask the bottom two bits.
    // 0x0080: This bit and the next track which 2F decoration style is being used (0: SANDORIA, 1: BASTOK, 2: WINDURST, 3: PATIO)
    // 0x0100: ^ As above
    uint16 moghouse2FModel      = 0x0267 + ((PChar->profile.mhflag >> 7) & 0x03);
    bool   requestingMoghouse2F = PChar->profile.mhflag & 0x40;
    if (requestingMoghouse2F)
    {
        return moghouse2FModel;
    }

    // clang-format off
    switch (zoneutils::GetCurrentRegion(PChar->getZone()))
    {
        case REGION_TYPE::WEST_AHT_URHGAN:
            return 214;
        case REGION_TYPE::RONFAURE_FRONT:
            return 745;
        case REGION_TYPE::GUSTABERG_FRONT:
            return 199;
        case REGION_TYPE::SARUTA_FRONT:
            return 219;
        case REGION_TYPE::SANDORIA:
            return PChar->profile.nation == NATION_SANDORIA ? 0x0121 : 0x0101;
        case REGION_TYPE::BASTOK:
            return PChar->profile.nation == NATION_BASTOK ? 0x0122 : 0x0102;
        case REGION_TYPE::WINDURST:
            return PChar->profile.nation == NATION_WINDURST ? 0x0123 : 0x0120;
        case REGION_TYPE::JEUNO:
            return 0x0100;
        case REGION_TYPE::ADOULIN_ISLANDS:
            return 0x0124;
        default:
            ShowWarning("Default case reached for GetMogHouseID by %s (%u)", PChar->getName(), PChar->getZone());
            return 0x0100;
    }
    // clang-format on
}

uint8 GetMogHouseLeavingFlag(CCharEntity* PChar)
{
    switch (zoneutils::GetCurrentRegion(PChar->getZone()))
    {
        case REGION_TYPE::WEST_AHT_URHGAN:
            if (PChar->profile.mhflag & 0x10)
            {
                return 5;
            }
            break;
        case REGION_TYPE::SANDORIA:
            if (PChar->profile.mhflag & 0x01)
            {
                return 1;
            }
            break;
        case REGION_TYPE::BASTOK:
            if (PChar->profile.mhflag & 0x02)
            {
                return 2;
            }
            break;
        case REGION_TYPE::WINDURST:
            if (PChar->profile.mhflag & 0x04)
            {
                return 3;
            }
            break;
        case REGION_TYPE::JEUNO:
            if (PChar->profile.mhflag & 0x08)
            {
                return 4;
            }
            break;
        default:
            break;
    }
    return 0;
}

CZoneInPacket::CZoneInPacket(CCharEntity* PChar, const EventInfo* currentEvent)
{
    this->setType(0x0A);
    this->setSize(0x104);

    // It is necessary to work Manaclipper
    // The last 8 bytes are similar for a while
    // unsigned char packet [] = {
    // 0x0D, 0x3A, 0x0C, 0x00, 0x11, 0x00, 0x19, 0x00, 0x02, 0xE4, 0x93, 0x10, 0x91, 0xE5, 0x93, 0x10}; // 0x2a = 0x10
    // 0x89, 0x39, 0x0C, 0x00, 0x19, 0x00, 0x07, 0x00, 0x5C, 0xE1, 0x93, 0x10, 0x81, 0xE3, 0x93, 0x10}; // 0x2a = 0x08
    // std::memcpy(buffer_.data() + 0x70, &packet, 16);

    // data[0x2A] = 0x08;//data[0x2A] = 0x80;  // in zone 3 controls the routes of transport 0x10 and 0x08

    ref<uint32>(0x04) = PChar->id;
    ref<uint16>(0x08) = PChar->targid;

    // 0x0A = Padding

    ref<uint8>(0x0B) = PChar->loc.p.rotation;
    ref<float>(0x0C) = PChar->loc.p.x;
    ref<float>(0x10) = PChar->loc.p.y;
    ref<float>(0x14) = PChar->loc.p.z;

    // 0x18 = Run Count

    // 0x1A = Target Index

    ref<uint8>(0x1C) = PChar->UpdateSpeed();
    ref<uint8>(0x1D) = PChar->animationSpeed;
    ref<uint8>(0x1E) = PChar->GetHPP();
    ref<uint8>(0x1F) = PChar->animation;

    // 0x20 = Character Gender and Size

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
    {
        ref<uint8>(0x20) = static_cast<uint8>(PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetSubPower());
    }

    ref<uint8>(0x21) = PChar->GetGender() * 128 + (1 << PChar->look.size);

    ref<uint16>(0x28) = 0x0100; // "Always 0x100"

    // 0x2A = Zone Animation

    look_t* look      = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);
    ref<uint8>(0x44)  = look->face;
    ref<uint8>(0x45)  = look->race;
    ref<uint16>(0x46) = PChar->playerConfig.DisplayHeadOffFlg ? 0x0 : look->head + 0x1000;
    ref<uint16>(0x48) = look->body + 0x2000;
    ref<uint16>(0x4A) = look->hands + 0x3000;
    ref<uint16>(0x4C) = look->legs + 0x4000;
    ref<uint16>(0x4E) = look->feet + 0x5000;
    ref<uint16>(0x50) = look->main + 0x6000;
    ref<uint16>(0x52) = look->sub + 0x7000;
    ref<uint16>(0x54) = look->ranged + 0x8000;

    ref<uint16>(0x56) = PChar->PInstance ? PChar->PInstance->GetBackgroundMusicDay() : PChar->loc.zone->GetBackgroundMusicDay();
    ref<uint16>(0x58) = PChar->PInstance ? PChar->PInstance->GetBackgroundMusicNight() : PChar->loc.zone->GetBackgroundMusicNight();
    ref<uint16>(0x5A) = PChar->PInstance ? PChar->PInstance->GetSoloBattleMusic() : PChar->loc.zone->GetSoloBattleMusic();
    ref<uint16>(0x5C) = PChar->PInstance ? PChar->PInstance->GetPartyBattleMusic() : PChar->loc.zone->GetPartyBattleMusic();
    ref<uint8>(0x5E)  = PChar->animation == ANIMATION_MOUNT ? 0x54 : 0xD4;

    ref<uint16>(0x60) = PChar->loc.boundary;
    ref<uint16>(0x68) = PChar->loc.zone->GetWeather();
    ref<uint32>(0x6A) = PChar->loc.zone->GetWeatherChangeTime();

    // TODO: Could this be previous weather, for weather transitions?
    // ref<uint32>(0x6C) = PChar->loc.zone->GetWeather();
    // ref<uint32>(0x70) = PChar->loc.zone->GetWeatherChangeTime();

    auto csid = currentEvent->eventId;
    if (csid != -1)
    {
        // ref<uint8>(data,(0x1F)) = 4; // Presumably Animation
        // ref<uint8>(data,(0x20)) = 2;

        ref<uint16>(0x40) = PChar->currentEvent->textTable == -1 ? PChar->getZone() : PChar->currentEvent->textTable;
        ref<uint16>(0x62) = PChar->getZone();
        ref<uint16>(0x64) = currentEvent->eventId;

        // Note that only the first 16 bits are supported by this packet type.
        ref<uint16>(0x66) = currentEvent->eventFlags & 0xFFFF;
    }

    ref<uint16>(0x30) = PChar->getZone();
    ref<uint16>(0x42) = PChar->getZone();

    if (PChar->m_moghouseID != 0)
    {
        ref<uint8>(0x80) = 0x01;

        if (PChar->profile.mhflag & 0x0040) // On MH2F
        {
            // Ensure full exit menu appears
            ref<uint16>(0xA8) = 0x02;
        }

        ref<uint16>(0xAA) = GetMogHouseModelID(PChar);
    }
    else
    {
        ref<uint8>(0x80)  = 0x02;
        ref<uint16>(0xAA) = 0x01FF;

        // TODO: This has also been seen as 0x04 and 0x07
        ref<uint8>(0xAC) = csid > 0 ? 0x01 : 0x00;                    // if 0x01 then pause between zone
        ref<uint8>(0xAF) = PChar->loc.zone->CanUseMisc(MISC_MOGMENU); // flag allows you to use Mog Menu outside Mog House
    }

    auto const& nameStr = PChar->getName();
    std::memcpy(buffer_.data() + 0x84, nameStr.data(), nameStr.size());

    ref<uint32>(0xA0) = PChar->GetPlayTime(); // time spent by the character in the game from the moment of creation

    ref<uint8>(0xAE) = GetMogHouseLeavingFlag(PChar);

    uint32 pktTime = CVanaTime::getInstance()->getVanaTime();

    ref<uint32>(0x38) = pktTime + VTIME_BASEDATE;
    ref<uint32>(0x3C) = pktTime;

    ref<uint32>(0xA4) = PChar->GetTimeRemainingUntilDeathHomepoint();

    ref<uint8>(0xB4) = PChar->GetMJob();
    ref<uint8>(0xB7) = PChar->GetSJob();

    std::memcpy(buffer_.data() + 0xCC, &PChar->stats, 14);

    ref<uint32>(0xE8) = PChar->GetMaxHP();
    ref<uint32>(0xEC) = PChar->GetMaxMP();
    // ref<uint8>(0xEF) = TODO: implement flag of 1 = high for "has unlocked sub and can change jobs"

    std::memcpy(&buffer_[offsetof(GP_SERV_LOGIN, ConfData)], &PChar->playerConfig, sizeof(SAVE_CONF_PKT));

    ref<uint8>(0x100) = 0x01; // observed: RoZ = 3, CoP = 5, ToAU = 9, WoTG = 11, SoA/original areas = 1

    if (PChar->GetMJob() == JOB_MON)
    {
        monstrosity::ReadMonstrosityData(PChar);
    }

    if (PChar->loc.zone->GetID() == ZONE_FERETORY)
    {
        // This disables the zone model, but also disables abilities etc.
        ref<uint8>(0x80) = 0x01;

        // Zone Model
        ref<uint16>(0xAA) = 0x02D9; // 729
    }

    if (PChar->m_PMonstrosity != nullptr)
    {
        // look_t data from above
        ref<uint16>(0x44) = PChar->m_PMonstrosity->Look;
        ref<uint16>(0x54) = 0xFFFF;

        // Enable Monstrosity menu options
        ref<uint8>(0x7E) = 0x1F;

        ref<uint32>(0x98) = monstrosity::GetPackedMonstrosityName(PChar);
    }
}
