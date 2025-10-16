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

#include "0x0cb_myroom_is.h"

#include "entities/charentity.h"
#include "enums/msg_std.h"
#include "utils/charutils.h"

namespace
{
    const std::map<uint8, GP_CLI_COMMAND_MYROOM_IS_PARAM2> default2fStyles = {
        { NATION_SANDORIA, GP_CLI_COMMAND_MYROOM_IS_PARAM2::SandorianStyle },
        { NATION_BASTOK, GP_CLI_COMMAND_MYROOM_IS_PARAM2::BastokanStyle },
        { NATION_WINDURST, GP_CLI_COMMAND_MYROOM_IS_PARAM2::WindurstianStyle },
    };

    const auto isRentARoom = [](const CCharEntity* PChar)
    {
        switch (PChar->profile.nation)
        {
            case NATION_SANDORIA:
                return PChar->loc.zone->GetRegionID() != REGION_TYPE::SANDORIA;
            case NATION_BASTOK:
                return PChar->loc.zone->GetRegionID() != REGION_TYPE::BASTOK;
            case NATION_WINDURST:
                return PChar->loc.zone->GetRegionID() != REGION_TYPE::WINDURST;
            default:
                return true;
        }
    };
} // namespace

auto GP_CLI_COMMAND_MYROOM_IS::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(PChar->m_moghouseID, PChar->id, "Character not in their mog house")
        .oneOf<GP_CLI_COMMAND_MYROOM_IS_KIND>(Kind)
        .oneOf<GP_CLI_COMMAND_MYROOM_IS_PARAM2>(Param2);
}

void GP_CLI_COMMAND_MYROOM_IS::process(MapSession* PSession, CCharEntity* PChar) const
{
    // Note: If you're in a Rent-a-Room, these commands are not available to the client.
    // However, retail will honor each of them if injected.
    if (isRentARoom(PChar))
    {
        ShowWarning(fmt::format("Player {} modifying Rent-a-Room state.", PChar->getName()));
    }

    switch (static_cast<GP_CLI_COMMAND_MYROOM_IS_KIND>(Kind))
    {
        case GP_CLI_COMMAND_MYROOM_IS_KIND::Open:
            // Not implemented
            // NOTE: If you zone or move floors while in the MH and you have someone visiting, they will be booted.
            // NOTE: When you zone or move floors your "open MH" flag will be reset.
            break;
        case GP_CLI_COMMAND_MYROOM_IS_KIND::Close:
            // Not implemented
            break;
        case GP_CLI_COMMAND_MYROOM_IS_KIND::Remodel:
        {
            auto newStyle = Param2;

            // Retail forces you to nation default style on invalid Param2.
            auto default2fStyle = GP_CLI_COMMAND_MYROOM_IS_PARAM2::SandorianStyle;
            if (default2fStyles.contains(PChar->profile.nation))
            {
                default2fStyle = default2fStyles.at(PChar->profile.nation);
            }

            if (!(PChar->profile.mhflag & 0x0020))
            {
                ShowWarning(fmt::format("Player {} remodeling MH2F without it unlocked.", PChar->getName()));
            }

            if (Param2 == static_cast<uint16_t>(GP_CLI_COMMAND_MYROOM_IS_PARAM2::MogPatio) && !charutils::hasKeyItem(PChar, KeyItem::MOG_PATIO_DESIGN_DOCUMENT))
            {
                ShowWarning(fmt::format("Player {} remodeling MH2F to Patio without owning the KI to unlock it.", PChar->getName()));
                newStyle = static_cast<uint16_t>(default2fStyle);
            }

            // 0x0080: This bit and the next track which 2F decoration style is being used (0: SANDORIA, 1: BASTOK, 2: WINDURST, 3: PATIO)
            // 0x0100: ^ As above

            // Extract original model and add 615 so it's in line with what comes in with the packet.
            const uint16 oldType = static_cast<uint16_t>(((PChar->profile.mhflag & 0x0100) + (PChar->profile.mhflag & 0x0080)) >> 7) + 615;

            // Clear bits first
            PChar->profile.mhflag &= ~(0x0080);
            PChar->profile.mhflag &= ~(0x0100);

            // Write new model bits
            PChar->profile.mhflag |= ((newStyle - 615) << 7);
            charutils::SaveCharStats(PChar);

            // Note: The forced zone may bypass this message.
            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::SuccessfulRemodel);

            // If the model changes AND you're on MH2F; force a rezone so the model change can take effect.
            if (Param2 != oldType && PChar->profile.mhflag & 0x0040)
            {
                const auto zoneid = PChar->getZone();

                PChar->loc.destination = zoneid;
                PChar->status          = STATUS_TYPE::DISAPPEAR;

                PChar->clearPacketList();
                PChar->requestedZoneChange = true;
            }
        }
        break;
    }
}
