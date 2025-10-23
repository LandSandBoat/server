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

#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "packets/s2c/0x053_systemmes.h"
#include "packets/s2c/0x065_wpos2.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

namespace
{
    constexpr auto mogHouseZoneLine = 1903324538;

    const auto denyZone = [](CCharEntity* PChar)
    {
        PChar->loc.p.rotation += 128;

        PChar->pushPacket<GP_SERV_COMMAND_SYSTEMMES>(0, 0, MsgStd::CouldNotEnter);
        PChar->pushPacket<GP_SERV_COMMAND_WPOS2>(PChar, PChar->loc.p, POSMODE::RESET);

        PChar->status = STATUS_TYPE::NORMAL;
    };
} // namespace

auto GP_CLI_COMMAND_MAPRECT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT>(MyRoomExitBit)
        .oneOf<GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE>(MyRoomExitMode);
}

void GP_CLI_COMMAND_MAPRECT::process(MapSession* PSession, CCharEntity* PChar) const
{
    uint16_t startingZone = PChar->getZone();
    auto     startingPos  = PChar->loc.p;

    PChar->ClearTrusts();

    if (PChar->status == STATUS_TYPE::NORMAL)
    {
        PChar->status       = STATUS_TYPE::DISAPPEAR;
        PChar->loc.boundary = 0;

        // Exiting Mog House
        if (RectID == mogHouseZoneLine)
        {
            uint16_t destinationZone = PChar->getZone();

            switch (static_cast<GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE>(MyRoomExitMode))
            {
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::AreaEnteredFrom:
                    // Return to current zone
                    break;
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option1:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option2:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option3:
                case GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Option4:
                    switch (static_cast<GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT>(MyRoomExitBit))
                    {
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::SandOria:
                            destinationZone = MyRoomExitMode + ZONE_SOUTHERN_SANDORIA - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Bastok:
                            destinationZone = MyRoomExitMode + ZONE_BASTOK_MINES - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Windurst:
                            destinationZone = MyRoomExitMode + ZONE_WINDURST_WATERS - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Jeuno:
                            destinationZone = MyRoomExitMode + ZONE_RULUDE_GARDENS - 1;
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Whitegate:
                            destinationZone = MyRoomExitMode + (MyRoomExitMode == 1 ? ZONE_AL_ZAHBI - 1 : ZONE_AHT_URHGAN_WHITEGATE - 2);
                            break;
                        case GP_CLI_COMMAND_MAPRECT_MYROOMEXITBIT::Adoulin:
                            destinationZone = MyRoomExitMode == 2 ? ZONE_EASTERN_ADOULIN : ZONE_WESTERN_ADOULIN;
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

            bool moghouseExitRegular          = MyRoomExitMode == static_cast<uint8>(GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::AreaEnteredFrom) && PChar->m_moghouseID > 0;
            bool requestedMoghouseFloorChange = startingZone == destinationZone && (MyRoomExitMode == static_cast<uint8>(GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog1F) || MyRoomExitMode == static_cast<uint8>(GP_CLI_COMMAND_MAPRECT_MYROOMEXITMODE::Mog2F));
            bool moghouse2FUnlocked           = PChar->profile.mhflag & 0x20;
            auto startingRegion               = zoneutils::GetCurrentRegion(startingZone);
            auto destinationRegion            = zoneutils::GetCurrentRegion(destinationZone);
            auto moghouseExitRegions          = { REGION_TYPE::SANDORIA, REGION_TYPE::BASTOK, REGION_TYPE::WINDURST, REGION_TYPE::JEUNO, REGION_TYPE::WEST_AHT_URHGAN, REGION_TYPE::ADOULIN_ISLANDS };
            auto moghouseSameRegion           = std::any_of(moghouseExitRegions.begin(), moghouseExitRegions.end(),
                                                            [&destinationRegion](const REGION_TYPE acceptedReg)
                                                            { return destinationRegion == acceptedReg; });
            auto moghouseQuestComplete        = PChar->profile.mhflag & (MyRoomExitBit ? 0x01 << (MyRoomExitBit - 1) : 0);

            if (startingRegion == REGION_TYPE::ADOULIN_ISLANDS)
            {
                // Adoulin back-alley exits are always available.
                moghouseQuestComplete = true;
            }

            bool moghouseExitQuestZoneline = moghouseQuestComplete &&
                                             startingRegion == destinationRegion &&
                                             PChar->m_moghouseID > 0 &&
                                             moghouseSameRegion &&
                                             !requestedMoghouseFloorChange;

            bool moghouseExitMogGardenZoneline = destinationZone == ZONE_MOG_GARDEN && PChar->m_moghouseID > 0;

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
            if (zoneLine_t* PZoneLine = PChar->loc.zone->GetZoneLine(RectID); !PZoneLine)
            {
                ShowError("GP_CLI_COMMAND_MAPRECT: Zone line %u not found", RectID);

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
                // Ensure the destination exists
                CZone* PDestination = zoneutils::GetZone(PZoneLine->m_toZone);
                if (PDestination && (PDestination->GetIP() == 0 || PDestination->GetPort() == 0))
                {
                    ShowDebug("GP_CLI_COMMAND_MAPRECT: Zone %u closed to chars", PZoneLine->m_toZone);

                    denyZone(PChar);
                    return;
                }

                if (PZoneLine->m_toZone == 0)
                {
                    // TODO: for entering another persons mog house, it must be set here
                    PChar->m_moghouseID    = PChar->id;
                    PChar->loc.p           = PZoneLine->m_toPos;
                    PChar->loc.destination = PChar->getZone();
                }
                else
                {
                    PChar->loc.destination = PZoneLine->m_toZone;
                    PChar->loc.p           = PZoneLine->m_toPos;
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
