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

#include "0x0e7_reqlogout.h"

#include "entities/charentity.h"
#include "status_effect_container.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_REQLOGOUT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .isNotCrafting(PChar)
        .isNormalStatus(PChar)
        .isNotPreventedAction(PChar)
        .oneOf<GP_CLI_COMMAND_REQLOGOUT_MODE>(Mode)
        .oneOf<GP_CLI_COMMAND_REQLOGOUT_KIND>(Kind);
}

void GP_CLI_COMMAND_REQLOGOUT::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* existingEffect = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_LEAVEGAME);

    auto applyLeaveGame = [&](GP_CLI_COMMAND_REQLOGOUT_KIND kind)
    {
        if (existingEffect)
        {
            // Player may have a different kind of leave game, just change the stored Kind.
            existingEffect->SetPower(static_cast<uint16>(kind));
        }
        else
        {
            // Apply new LeaveGame and store the kind as the power.
            const auto leaveEffect = new CStatusEffect(EFFECT_LEAVEGAME, 0, static_cast<uint16>(kind), 5s, 0s);
            PChar->StatusEffectContainer->AddStatusEffect(leaveEffect);
        }
    };

    auto removeLeaveGame = [&]()
    {
        if (existingEffect)
        {
            PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEAVEGAME);
        }
    };

    switch (static_cast<GP_CLI_COMMAND_REQLOGOUT_KIND>(Kind))
    {
        case GP_CLI_COMMAND_REQLOGOUT_KIND::Logout:
            switch (static_cast<GP_CLI_COMMAND_REQLOGOUT_MODE>(Mode))
            {
                case GP_CLI_COMMAND_REQLOGOUT_MODE::Toggle:
                    if (existingEffect)
                    {
                        removeLeaveGame();
                    }
                    else
                    {
                        applyLeaveGame(GP_CLI_COMMAND_REQLOGOUT_KIND::Logout);
                    }
                    break;
                case GP_CLI_COMMAND_REQLOGOUT_MODE::LogoutOn:
                    applyLeaveGame(GP_CLI_COMMAND_REQLOGOUT_KIND::Logout);
                    break;
                case GP_CLI_COMMAND_REQLOGOUT_MODE::Off:
                    removeLeaveGame();
                    break;
                case GP_CLI_COMMAND_REQLOGOUT_MODE::ShutdownOn:
                    // Impossible without a crafted packet.
                    break;
            }
            break;
        case GP_CLI_COMMAND_REQLOGOUT_KIND::Shutdown:
            switch (static_cast<GP_CLI_COMMAND_REQLOGOUT_MODE>(Mode))
            {
                case GP_CLI_COMMAND_REQLOGOUT_MODE::Toggle:
                    if (existingEffect)
                    {
                        removeLeaveGame();
                    }
                    else
                    {
                        applyLeaveGame(GP_CLI_COMMAND_REQLOGOUT_KIND::Shutdown);
                    }
                    break;
                case GP_CLI_COMMAND_REQLOGOUT_MODE::LogoutOn:
                    // Impossible without a crafted packet.
                    break;
                case GP_CLI_COMMAND_REQLOGOUT_MODE::Off:
                    removeLeaveGame();
                    break;
                case GP_CLI_COMMAND_REQLOGOUT_MODE::ShutdownOn:
                    applyLeaveGame(GP_CLI_COMMAND_REQLOGOUT_KIND::Shutdown);
                    break;
            }
            break;
    }
}
