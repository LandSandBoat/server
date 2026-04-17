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

#include <string_view>

#include "common/utils.h"
#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "navmesh.h"
#include "packets/s2c/0x053_systemmes.h"
#include "packets/s2c/0x065_wpos2.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

namespace
{

const auto denyZone = [](CCharEntity* PChar)
{
    // TODO: Retail handling:
    // - Tripped poshack check: Placed somewhere on the corresponding 'exit' zoneline
    // - Failed distance check: No movement
    // - Invalid zoneline (observed in Kamihr): Placed on a different zoneline
    PChar->loc.p.rotation += 128;

    PChar->pushPacket<GP_SERV_COMMAND_SYSTEMMES>(0, 0, MsgStd::CouldNotEnter);
    PChar->pushPacket<GP_SERV_COMMAND_WPOS2>(PChar, PChar->loc.p, POSMODE::RESET);

    PChar->status = STATUS_TYPE::NORMAL;
};

} // namespace

auto GP_CLI_COMMAND_MAPRECT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .oneOf<GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT>(this->MyRoomExitBit)
        .oneOf<GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE>(this->MyRoomExitMode);
}

void GP_CLI_COMMAND_MAPRECT::process(MapSession* PSession, CCharEntity* PChar) const
{
    uint16_t startingZone = PChar->getZone();
    auto     startingPos  = PChar->loc.p;

    PChar->ClearTrusts();

    // RectID is a uint32_t holding a 4-character zoneline tag (fourcc); reinterpret as exactly 4 bytes (no trailing NUL).
    const std::string_view rectView(reinterpret_cast<const char*>(&this->RectID), 4);

    const auto isMogHouseExit = rectView == "zmrq"; // universal Mog House exit zoneline

    const std::string_view mogEntrancePrefix  = rectView.substr(0, 3);
    const auto             isMogHouseEntrance = mogEntrancePrefix == "zmr" || mogEntrancePrefix == "zms"; // zmr* classic cities; zms* WoTG [S] + Adoulin

    if (PChar->status == STATUS_TYPE::NORMAL)
    {
        PChar->status       = STATUS_TYPE::DISAPPEAR;
        PChar->loc.boundary = 0;

        // Exiting Mog House
        if (isMogHouseExit)
        {
            uint16_t destinationZone = PChar->getZone();

            switch (static_cast<GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE>(this->MyRoomExitMode))
            {
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::AreaEnteredFrom:
                    // Return to current zone
                    break;
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option1:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option2:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option3:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option4:
                    switch (static_cast<GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT>(this->MyRoomExitBit))
                    {
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::SandOria:
                            destinationZone = this->MyRoomExitMode + ZONE_SOUTHERN_SANDORIA - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Bastok:
                            destinationZone = this->MyRoomExitMode + ZONE_BASTOK_MINES - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Windurst:
                            destinationZone = this->MyRoomExitMode + ZONE_WINDURST_WATERS - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Jeuno:
                            destinationZone = this->MyRoomExitMode + ZONE_RULUDE_GARDENS - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Whitegate:
                            destinationZone = this->MyRoomExitMode + (this->MyRoomExitMode == 1 ? ZONE_AL_ZAHBI - 1 : ZONE_AHT_URHGAN_WHITEGATE - 2);
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Adoulin:
                            destinationZone = this->MyRoomExitMode == 2 ? ZONE_EASTERN_ADOULIN : ZONE_WESTERN_ADOULIN;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::RonfaureFront:
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::GustabergFront:
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::SarutaFront:
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Default:
                            // Impossible to get here without a crafted packet
                            // TODO: Verify retail handling of the case
                            return;
                    }
                    break;
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog1F:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog2F:
                    destinationZone = PChar->getZone();
                    break;
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::MogGarden:
                    destinationZone = ZONE_MOG_GARDEN;
                    break;
            }

            bool moghouseExitRegular          = this->MyRoomExitMode == static_cast<uint8>(GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::AreaEnteredFrom) && PChar->inMogHouse();
            bool requestedMoghouseFloorChange = startingZone == destinationZone && (this->MyRoomExitMode == static_cast<uint8>(GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog1F) || this->MyRoomExitMode == static_cast<uint8>(GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog2F));
            bool moghouse2FUnlocked           = PChar->profile.mhflag & 0x20;
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

            bool moghouseExitMogGardenZoneline = destinationZone == ZONE_MOG_GARDEN && PChar->inMogHouse();

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
                    PChar->status = STATUS_TYPE::NORMAL;
                    ShowWarning("GP_CLI_COMMAND_MAPRECT: Moghouse 2F requested without it being unlocked: %s", PChar->getName());
                    return;
                }
            }
            else
            {
                PChar->status = STATUS_TYPE::NORMAL;
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

                    // Snap to navmesh for elevation on uneven zonelines
                    if (PDestination && PDestination->m_navMesh)
                    {
                        PDestination->m_navMesh->snapToValidPosition(PChar->loc.p);
                    }

                    charutils::SavePrevZoneLineID(PChar, PZoneLine->zoneLineId);
                }
            }
        }

        ShowInfo("Zoning from zone %u to zone %u: %s", PChar->getZone(), PChar->loc.destination, PChar->getName());
    }

    PChar->clearPacketList();

    if (PChar->loc.destination >= MAX_ZONEID)
    {
        ShowWarning("GP_CLI_COMMAND_MAPRECT: Invalid destination passed to packet %u by %s", PChar->loc.destination, PChar->getName());
        PChar->loc.destination = startingZone;
        return;
    }

    auto destination = PChar->loc.destination == 0 ? PChar->getZone() : PChar->loc.destination;
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
