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

#include "0x05e_maprect.h"

#include <optional>
#include <string_view>

#include "common/settings.h"
#include "common/utils.h"
#include "entities/char_entity.h"
#include "enums/msg_std.h"
#include "packets/s2c/0x053_systemmes.h"
#include "packets/s2c/0x065_wpos2.h"
#include "status_effect.h"
#include "status_effect_container.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

namespace
{

const auto denyZone = [](CCharEntity* PChar, MsgStd message = MsgStd::CouldNotEnter)
{
    // TODO: Retail handling:
    // - Tripped poshack check: Placed somewhere on the corresponding 'exit' zoneline
    // - Failed distance check: No movement
    // - Invalid zoneline (observed in Kamihr): Placed on a different zoneline
    PChar->loc.p.rotation += 128;

    PChar->pushPacket<GP_SERV_COMMAND_SYSTEMMES>(0, 0, message);
    PChar->pushPacket<GP_SERV_COMMAND_WPOS2>(PChar, PChar->loc.p, POSMODE::RESET);

    PChar->status = xi::Status::Normal;
};

const auto isRidingRentalChocobo = [](const CCharEntity* PChar) -> bool
{
    const auto* effect = PChar->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Mounted);
    return effect != nullptr && effect->GetPower() == MOUNT_CHOCOBO && effect->GetSubPower() == 0;
};

} // namespace

auto GP_CLI_COMMAND_MAPRECT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .oneOf<GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT>(this->MyRoomExitBit)
        .oneOf<GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE>(this->MyRoomExitMode);
}

// Mog House exits index forward from the first zone of a city, e.g. Southern -> Northern -> Port San d'Oria.
namespace
{

auto moghouseCityExit(const GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT exitBit, const uint8 mode) -> std::optional<xi::ZoneId>
{
    switch (exitBit)
    {
        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::SandOria:
            switch (mode)
            {
                case 1:
                    return xi::ZoneId::SouthernSanDoria;
                case 2:
                    return xi::ZoneId::NorthernSanDoria;
                case 3:
                    return xi::ZoneId::PortSanDoria;
            }
            break;
        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Bastok:
            switch (mode)
            {
                case 1:
                    return xi::ZoneId::BastokMines;
                case 2:
                    return xi::ZoneId::BastokMarkets;
                case 3:
                    return xi::ZoneId::PortBastok;
            }
            break;
        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Windurst:
            switch (mode)
            {
                case 1:
                    return xi::ZoneId::WindurstWaters;
                case 2:
                    return xi::ZoneId::WindurstWalls;
                case 3:
                    return xi::ZoneId::PortWindurst;
                case 4:
                    return xi::ZoneId::WindurstWoods;
            }
            break;
        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Jeuno:
            switch (mode)
            {
                case 1:
                    return xi::ZoneId::RuludeGardens;
                case 2:
                    return xi::ZoneId::UpperJeuno;
                case 3:
                    return xi::ZoneId::LowerJeuno;
                case 4:
                    return xi::ZoneId::PortJeuno;
            }
            break;
        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Whitegate:
            switch (mode)
            {
                case 1:
                    return xi::ZoneId::AlZahbi;
                case 2:
                    return xi::ZoneId::AhtUrhganWhitegate;
            }
            break;
        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Adoulin:
            switch (mode)
            {
                case 1:
                    return xi::ZoneId::WesternAdoulin;
                case 2:
                    return xi::ZoneId::EasternAdoulin;
            }
            break;
        default:
            break;
    }

    return std::nullopt;
}

} // namespace

void GP_CLI_COMMAND_MAPRECT::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto startingZone = PChar->getZone();
    auto       startingPos  = PChar->loc.p;

    PChar->ClearTrusts();

    // RectID is a uint32_t holding a 4-character zoneline tag (fourcc); reinterpret as exactly 4 bytes (no trailing NUL).
    const std::string_view rectView(reinterpret_cast<const char*>(&this->RectID), 4);

    const auto isMogHouseExit = rectView == "zmrq"; // universal Mog House exit zoneline

    const std::string_view mogEntrancePrefix  = rectView.substr(0, 3);
    const auto             isMogHouseEntrance = mogEntrancePrefix == "zmr" || mogEntrancePrefix == "zms"; // zmr* classic cities; zms* WoTG [S] + Adoulin

    if (PChar->status == xi::Status::Normal)
    {
        PChar->status       = xi::Status::Disappear;
        PChar->loc.boundary = 0;

        // Exiting Mog House
        if (isMogHouseExit)
        {
            auto destinationZone = PChar->getZone();

            auto exitDestination = static_cast<GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE>(this->MyRoomExitMode);

            if (!settings::get<bool>("main.ENABLE_MOG_GARDEN"))
            {
                // If Mog Garden is disabled, send the request as a regular mog house exit.
                if (exitDestination == GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::MogGarden)
                {
                    exitDestination = GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::AreaEnteredFrom;
                }
            }

            switch (exitDestination)
            {
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::AreaEnteredFrom:
                    // Return to current zone
                    break;
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option1:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option2:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option3:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option4:
                {
                    const auto cityExit = moghouseCityExit(static_cast<GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT>(this->MyRoomExitBit), this->MyRoomExitMode);
                    if (!cityExit)
                    {
                        PChar->status = xi::Status::Normal;
                        return;
                    }

                    destinationZone = *cityExit;
                }
                break;
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog1F:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog2F:
                    destinationZone = PChar->getZone();
                    break;
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::MogGarden:
                    destinationZone = xi::ZoneId::MogGarden;
                    break;
            }

            bool moghouseExitRegular          = exitDestination == GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::AreaEnteredFrom && PChar->inMogHouse();
            bool requestedMoghouseFloorChange = PChar->inMogHouse() && startingZone == destinationZone && (exitDestination == GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog1F || exitDestination == GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog2F);
            bool moghouse2FUnlocked           = (PChar->profile.mhflag & 0x20) && settings::get<bool>("main.ENABLE_MOG_HOUSE_2F");
            auto startingRegion               = zoneutils::GetCurrentRegion(startingZone);
            auto destinationRegion            = zoneutils::GetCurrentRegion(destinationZone);
            auto moghouseExitRegions          = { REGION_TYPE::SANDORIA, REGION_TYPE::BASTOK, REGION_TYPE::WINDURST, REGION_TYPE::JEUNO, REGION_TYPE::WEST_AHT_URHGAN, REGION_TYPE::ADOULIN_ISLANDS };
            auto moghouseSameRegion           = std::ranges::any_of(moghouseExitRegions,
                                                                    [&destinationRegion](const REGION_TYPE acceptedReg)
                                                                    {
                                                              return destinationRegion == acceptedReg;
                                                                    });
            auto moghouseQuestComplete        = PChar->profile.mhflag & (this->MyRoomExitBit ? 0x01 << (this->MyRoomExitBit - 1) : 0);

            if (startingRegion == REGION_TYPE::ADOULIN_ISLANDS)
            {
                // Adoulin back-alley exits are always available.
                moghouseQuestComplete = true;
            }

            bool moghouseExitQuestZoneline = moghouseQuestComplete &&
                                             startingRegion == destinationRegion &&
                                             PChar->inMogHouse() &&
                                             moghouseSameRegion &&
                                             !requestedMoghouseFloorChange;

            bool moghouseExitMogGardenZoneline = destinationZone == xi::ZoneId::MogGarden && PChar->inMogHouse();

            // Validate travel
            if (moghouseExitRegular || moghouseExitQuestZoneline || moghouseExitMogGardenZoneline)
            {
                PChar->m_moghouseID    = 0;
                PChar->loc.destination = destinationZone;
                PChar->loc.p           = {};

                // Clear Moghouse 2F tracker flag
                PChar->profile.mhflag &= ~(0x40);
            }
            else if (requestedMoghouseFloorChange)
            {
                PChar->loc.destination = destinationZone;
                PChar->loc.p           = {};

                if (moghouse2FUnlocked)
                {
                    // Toggle Moghouse 2F tracker flag
                    PChar->profile.mhflag ^= 0x40;
                }
                else
                {
                    PChar->status = xi::Status::Normal;
                    ShowWarning("GP_CLI_COMMAND_MAPRECT: Moghouse 2F requested without it being unlocked: %s", PChar->getName());
                    return;
                }
            }
            else
            {
                PChar->status = xi::Status::Normal;
                ShowWarning("GP_CLI_COMMAND_MAPRECT: Moghouse zoneline abuse by %s", PChar->getName());
                return;
            }
        }
        else
        {
            // Ensure the zone line exists
            if (zoneLine_t* PZoneLine = PChar->loc.zone->GetZoneLine(this->RectID); !PZoneLine)
            {
                ShowError("GP_CLI_COMMAND_MAPRECT: Zone line %u not found", this->RectID);

                denyZone(PChar);
                return;
            }
            else if (PChar->m_PMonstrosity != nullptr) // Not allowed to use zonelines while MON
            {
                denyZone(PChar);
                return;
            }
            else
            {
                // 38-42y distance limit observed
                if (distance(PChar->loc.p, PZoneLine->originPos, true) > 40.0f)
                {
                    ShowWarning("GP_CLI_COMMAND_MAPRECT: %s too far from zoneline %u (%.1fy)",
                                PChar->getName(),
                                this->RectID,
                                distance(PChar->loc.p, PZoneLine->originPos, true));

                    denyZone(PChar);
                    return;
                }

                // Ensure the destination exists
                CZone* PDestination = zoneutils::GetZone(PZoneLine->destinationZoneId);
                if (PDestination && (PDestination->GetIP() == 0 || PDestination->GetPort() == 0))
                {
                    ShowDebug("GP_CLI_COMMAND_MAPRECT: Zone %u closed to chars", PZoneLine->destinationZoneId);

                    denyZone(PChar);
                    return;
                }

                if (!isMogHouseEntrance && zoneutils::IsZoneAtPlayerCap(PZoneLine->destinationZoneId, PChar->m_GMlevel > 0))
                {
                    denyZone(PChar);
                    return;
                }

                // A rental chocobo cannot be taken into a zone that does not permit riding.
                if (isRidingRentalChocobo(PChar) && !zoneutils::CanZoneUseMisc(PZoneLine->destinationZoneId, xi::ZoneMisc::Mount))
                {
                    denyZone(PChar, MsgStd::CannotEnterAreaWhileMounted);
                    return;
                }

                if (isMogHouseEntrance)
                {
                    // TODO: for entering another persons mog house, it must be set here
                    PChar->m_moghouseID    = PChar->id;
                    PChar->loc.p           = PZoneLine->destinationPos;
                    PChar->loc.destination = PChar->getZone();
                    PChar->loc.prevzone    = PChar->getZone();

                    charutils::SavePrevZoneLineID(PChar, PZoneLine->zoneLineId);
                }
                else
                {
                    PChar->loc.destination = PZoneLine->destinationZoneId;
                    PChar->loc.p           = PZoneLine->nextSpawnPosition();

                    charutils::SavePrevZoneLineID(PChar, PZoneLine->zoneLineId);
                }
            }
        }

        ShowInfo("Zoning from zone %u to zone %u: %s", PChar->getZone(), PChar->loc.destination, PChar->getName());
    }

    PChar->clearPacketList();

    if (static_cast<uint16>(PChar->loc.destination) >= MAX_ZONEID)
    {
        ShowWarning("GP_CLI_COMMAND_MAPRECT: Invalid destination passed to packet %u by %s", PChar->loc.destination, PChar->getName());
        PChar->loc.destination = startingZone;
        return;
    }

    auto destination = PChar->loc.destination == xi::ZoneId::Unknown ? PChar->getZone() : PChar->loc.destination;
    if (uint64_t ipp = zoneutils::GetZoneIPP(destination); ipp == 0)
    {
        ShowWarning(fmt::format("Char {} requested zone ({}) returned IPP of 0", PChar->name, destination));
        PChar->loc.destination = startingZone;
        PChar->loc.p           = startingPos;

        denyZone(PChar);
        return;
    }

    PChar->requestedZoneChange = true;

    // Save pet if any
    if (PChar->shouldPetPersistThroughZoning())
    {
        PChar->setPetZoningInfo();
    }
}
