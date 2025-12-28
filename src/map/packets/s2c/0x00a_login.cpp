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

#include "0x00a_login.h"

#include "entities/charentity.h"
#include "instance.h"
#include "status_effect_container.h"
#include "utils/zoneutils.h"

namespace
{

// Returns the Model ID of the mog house to be used
// This is not the same as the actual Zone ID!
// (These used to be entries in the ZONEID enum, but that was wrong, knowing what we know now)
auto GetMogHouseModelID(const CCharEntity* PChar) -> uint16
{
    // Shift right 7 places, mask the bottom two bits.
    // 0x0080: This bit and the next track which 2F decoration style is being used (0: SANDORIA, 1: BASTOK, 2: WINDURST, 3: PATIO)
    // 0x0100: ^ As above
    const uint16 moghouse2FModel = 0x0267 + ((PChar->profile.mhflag >> 7) & 0x03);
    if (PChar->profile.mhflag & 0x40)
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

auto GetMogHouseLeavingFlag(const CCharEntity* PChar) -> uint8
{
    switch (zoneutils::GetCurrentRegion(PChar->getZone()))
    {
        case REGION_TYPE::ADOULIN_ISLANDS:
            return 9; // Adoulin MH exit is always enabled
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

} // namespace

GP_SERV_COMMAND_LOGIN::GP_SERV_COMMAND_LOGIN(CCharEntity* PChar, const EventInfo* currentEvent)
{
    auto& packet = this->data();

    // The client uses 66min as the maximum amount of time for death
    // Once this value reaches below 6min then the client will force homepoint the character
    const auto deadRemaining = timer::count_seconds(6min + PChar->GetTimeUntilDeathHomepoint());
    const auto currentTime   = earth_time::now();
    uint32_t   flags2        = 0;

    // Mount sub power in byte 0 (bits 0-7)
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
    {
        flags2 |= static_cast<uint8>(PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetSubPower());
    }

    // Gender and size in byte 1 (bits 8-15)
    flags2 |= static_cast<uint32_t>(PChar->GetGender() * 128 + (1 << PChar->look.size)) << 8;

    packet.PosHead = {
        .UniqueNo      = PChar->id,
        .ActIndex      = PChar->targid,
        .dir           = static_cast<int8_t>(PChar->loc.p.rotation),
        .x             = PChar->loc.p.x,
        .z             = PChar->loc.p.y, // Not a typo
        .y             = PChar->loc.p.z,
        .Speed         = PChar->UpdateSpeed(),
        .SpeedBase     = PChar->animationSpeed,
        .HpMax         = PChar->GetHPP(),
        .server_status = PChar->animation,
        .flags2        = flags2,
        .flags4        = 0x0100,
    };

    // TODO: Previous weather
    packet.WeatherNumber = static_cast<uint16>(PChar->loc.zone->GetWeather());
    packet.WeatherTime   = PChar->loc.zone->GetWeatherChangeTime();
    packet.ZoneNo        = PChar->getZone();
    packet.MapNumber     = PChar->getZone();
    packet.SubMapNumber  = PChar->loc.boundary;
    packet.PlayTime      = static_cast<uint32>(timer::count_seconds(PChar->GetPlayTime()));
    packet.MyRoomExitBit = GetMogHouseLeavingFlag(PChar);
    packet.ntTimeSec     = earth_time::timestamp(currentTime);
    packet.GameTime      = earth_time::vanadiel_timestamp(currentTime);
    packet.DeadCounter   = static_cast<uint32>(60 * deadRemaining);
    packet.Ex            = 0x01;

    const look_t* look  = PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look;
    packet.GrapIDTbl[0] = look->face | look->race << 8;
    packet.GrapIDTbl[1] = PChar->playerConfig.DisplayHeadOffFlg ? 0x0 : look->head + 0x1000;
    packet.GrapIDTbl[2] = look->body + 0x2000;
    packet.GrapIDTbl[3] = look->hands + 0x3000;
    packet.GrapIDTbl[4] = look->legs + 0x4000;
    packet.GrapIDTbl[5] = look->feet + 0x5000;
    packet.GrapIDTbl[6] = look->main + 0x6000;
    packet.GrapIDTbl[7] = look->sub + 0x7000;
    packet.GrapIDTbl[8] = look->ranged + 0x8000;

    packet.MusicNum[0] = PChar->PInstance ? PChar->PInstance->GetBackgroundMusicDay() : PChar->loc.zone->GetBackgroundMusicDay();
    packet.MusicNum[1] = PChar->PInstance ? PChar->PInstance->GetBackgroundMusicNight() : PChar->loc.zone->GetBackgroundMusicNight();
    packet.MusicNum[2] = PChar->PInstance ? PChar->PInstance->GetSoloBattleMusic() : PChar->loc.zone->GetSoloBattleMusic();
    packet.MusicNum[3] = PChar->PInstance ? PChar->PInstance->GetPartyBattleMusic() : PChar->loc.zone->GetPartyBattleMusic();
    packet.MusicNum[4] = PChar->animation == ANIMATION_MOUNT ? 0x54 : 0xD4;

    const auto csid = currentEvent->eventId;
    if (csid != -1)
    {
        packet.EventNo   = PChar->currentEvent->textTable == -1 ? PChar->getZone() : PChar->currentEvent->textTable;
        packet.EventNum  = PChar->getZone();
        packet.EventPara = currentEvent->eventId;
        packet.EventMode = currentEvent->eventFlags & 0xFFFF;

        PChar->animation             = ANIMATION_EVENT;
        packet.PosHead.server_status = ANIMATION_EVENT;
    }

    if (PChar->inMogHouse())
    {
        packet.LoginState = SAVE_LOGIN_STATE::SAVE_LOGIN_STATE_MYROOM;

        if (PChar->profile.mhflag & 0x0040) // On MH2F
        {
            // Ensure full exit menu appears
            packet.MyroomSubMapNumber = 0x02;
        }

        packet.MyroomMapNumber = GetMogHouseModelID(PChar);
    }
    else
    {
        packet.LoginState      = SAVE_LOGIN_STATE::SAVE_LOGIN_STATE_GAME;
        packet.MyroomMapNumber = 0x01FF;
        packet.SendCount       = csid > 0 ? 0x01 : 0x00;                    // TODO: SendCount is where we should put the number of King NPCs needed for the upcoming CS
        packet.MogZoneFlag     = PChar->loc.zone->CanUseMisc(MISC_MOGMENU); // flag allows you to use Mog Menu outside Mog House
    }

    const auto& nameStr = PChar->getName();
    std::memcpy(packet.name, nameStr.data(), std::min(nameStr.size(), sizeof(packet.name)));

    packet.Dancer = {
        .mjob_no = PChar->GetMJob(),
        .sjob_no = PChar->GetSJob(),
        .hpmax   = PChar->GetMaxHP(),
        .mpmax   = PChar->GetMaxMP(),
        .sjobflg = static_cast<uint8_t>(PChar->jobs.unlocked & 1),
    };

    std::memcpy(&packet.Dancer.bp_base, &PChar->stats, 14);
    std::memcpy(&packet.ConfData, &PChar->playerConfig, sizeof(SAVE_CONF_PKT));

    if (PChar->GetMJob() == JOB_MON)
    {
        monstrosity::ReadMonstrosityData(PChar);
    }

    if (PChar->loc.zone->GetID() == ZONE_FERETORY)
    {
        // This disables the zone model, but also disables abilities etc.
        packet.LoginState      = SAVE_LOGIN_STATE::SAVE_LOGIN_STATE_MYROOM;
        packet.MyroomMapNumber = 0x02D9; // 729
    }

    if (PChar->m_PMonstrosity != nullptr)
    {
        packet.GrapIDTbl[0] = PChar->m_PMonstrosity->Look;
        packet.GrapIDTbl[8] = 0xFFFF;

        packet.IsMonstrosity = 0x1F;
    }
}
