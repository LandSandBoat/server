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

#include "0x110_fishing_2.h"

#include "entities/charentity.h"

auto GP_CLI_COMMAND_FISHING_2::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(settings::get<bool>("map.FISHING_ENABLE"), true, "Fishing is disabled")
        .mustEqual(PChar->GetMLevel() >= settings::get<uint8>("map.FISHING_MIN_LEVEL"), true, "Character below fishing minimum level")
        .mustEqual(UniqueNo, PChar->id, "Character id mismatch")
        .mustEqual(ActIndex, PChar->targid, "Character targid mismatch")
        .oneOf<GP_CLI_COMMAND_FISHING_2_MODE>(mode)
        .custom([&](PacketValidator& v)
                {
                    // clang-format off
                    switch (static_cast<GP_CLI_COMMAND_FISHING_2_MODE>(mode))
                    {
                        case GP_CLI_COMMAND_FISHING_2_MODE::RequestCheckHook:
                            // para and para2 are both 0 for RequestCheckHook
                            v.mustEqual(para, 0, "para must be 0")
                                .mustEqual(para2, 0, "para2 must be 0");
                            break;
                        case GP_CLI_COMMAND_FISHING_2_MODE::RequestEndMiniGame:
                            // para has various values depending on the reason
                            // - Equals to 300 when client fails to catch a fish
                            // - Equals to 200 when client force exits the mini game
                            // - Equals to 0 when client successfully catches a fish
                            // - Else it is equal to the fish remaining stamina
                            v.range("para", para, 0, 300);

                            // if para2 is non-zero, it must equal current hooked fish special
                            if (para2 != 0)
                            {
                                if (PChar->hookedFish)
                                {
                                    v.mustEqual(para2, PChar->hookedFish->special, "para2 not equal to current hooked fish special");
                                }
                            }
                            break;
                        case GP_CLI_COMMAND_FISHING_2_MODE::RequestRelease:
                            // para and para2 are both 0 for RequestRelease
                            v.mustEqual(para, 0, "para must be 0")
                                .mustEqual(para2, 0, "para2 must be 0");
                            break;
                        case GP_CLI_COMMAND_FISHING_2_MODE::RequestPotentialTimeout:
                            // para is set to time remaining, para2 is always 0
                            // todo: unknown actual range, this parameter is currently unused
                            v.range("para", para, 0, 10)
                                .mustEqual(para2, 0, "para2 must be 0");
                            break;
                    }
                    // clang-format on
                });
}

void GP_CLI_COMMAND_FISHING_2::process(MapSession* PSession, CCharEntity* PChar) const
{
    fishingutils::FishingAction(PChar, static_cast<GP_CLI_COMMAND_FISHING_2_MODE>(mode), para, para2);
}
