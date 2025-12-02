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

#include "0x0db_config_language.h"

#include "entities/charentity.h"
#include "packets/char_status.h"
#include "packets/s2c/0x0b4_config.h"
#include "utils/charutils.h"

auto GP_CLI_COMMAND_CONFIG_LANGUAGE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_CONFIG_LANGUAGE_KIND>(Kind)
        .mustEqual(unknown00, 0, "unknown00 must be 0")
        .mustEqual(unknown01, 0, "unknown00 must be 0");
}

void GP_CLI_COMMAND_CONFIG_LANGUAGE::process(MapSession* PSession, CCharEntity* PChar) const
{
    uint32_t oldPlayerConfig = {};
    uint32_t oldChatFilter1  = {};
    uint32_t oldChatFilter2  = {};

    std::memcpy(&oldPlayerConfig, &PChar->playerConfig, sizeof(uint32_t));
    std::memcpy(&oldChatFilter1, &PChar->playerConfig.MessageFilter, sizeof(uint32_t));
    std::memcpy(&oldChatFilter2, &PChar->playerConfig.MessageFilter2, sizeof(uint32_t));

    switch (static_cast<GP_CLI_COMMAND_CONFIG_LANGUAGE_KIND>(Kind))
    {
        case GP_CLI_COMMAND_CONFIG_LANGUAGE_KIND::SearchLanguage:
        {
            // Player is updating chat filters
            if (oldPlayerConfig != ConfigSys[0])
            {
                std::memcpy(&PChar->playerConfig, &ConfigSys[0], sizeof(uint32_t));
                charutils::SavePlayerSettings(PChar);
            }

            if (oldChatFilter1 != ConfigSys[1] || oldChatFilter2 != ConfigSys[2])
            {
                std::memcpy(&PChar->playerConfig.MessageFilter, &ConfigSys[1], sizeof(uint32_t));
                std::memcpy(&PChar->playerConfig.MessageFilter2, &ConfigSys[2], sizeof(uint32_t));
                // It's probably not necessary to save the flags as they are sent by the client on login.
                charutils::SaveChatFilterFlags(PChar);
            }
        }
        break;
        case GP_CLI_COMMAND_CONFIG_LANGUAGE_KIND::PartyLanguages:
        {
            // Player is updating party search languages
            if (PChar->search.language != Param)
            {
                PChar->search.language = static_cast<uint8_t>(Param);
                charutils::SaveLanguages(PChar);
            }
        }
        break;
    }

    PChar->pushPacket<GP_SERV_COMMAND_CONFIG>(PChar);
    PChar->pushPacket<CCharStatusPacket>(PChar);
}
