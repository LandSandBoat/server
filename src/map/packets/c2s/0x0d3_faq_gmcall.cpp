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

#include "0x0d3_faq_gmcall.h"

#include "entities/charentity.h"

auto GP_CLI_COMMAND_FAQ_GMCALL::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .oneOf<GP_CLI_COMMAND_FAQ_GMCALL_TYPE>(this->type)
        .mustEqual(this->vers, 0, "vers not equal to 0")
        .range("eos", this->eos, 0, 1);
}

void GP_CLI_COMMAND_FAQ_GMCALL::process(MapSession* PSession, CCharEntity* PChar) const
{
    switch (static_cast<GP_CLI_COMMAND_FAQ_GMCALL_TYPE>(this->type))
    {
        case GP_CLI_COMMAND_FAQ_GMCALL_TYPE::AddHistory:
        {
            // Client sent extra information after acknowledging a response.
            // Contains several blocks, none of which are worth collecting at this point.
            break;
        }
        case GP_CLI_COMMAND_FAQ_GMCALL_TYPE::GMCall:
        {
            // User submitted a GM call. There can be many packets, but they should not be processed until eos == 1
            if (PChar->gmCallContainer().addPacket(*this))
            {
                // Received eos 1 - store in DB and send to ZMQ
                PChar->gmCallContainer().processCall(PChar);
                PChar->m_charHistory.gmCalls++;
            }
            break;
        }
        case GP_CLI_COMMAND_FAQ_GMCALL_TYPE::GMNotice:
        {
            // Unknown usage.
            break;
        }
    }
}
