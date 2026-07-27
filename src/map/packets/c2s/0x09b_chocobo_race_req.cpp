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

#include "0x09b_chocobo_race_req.h"

#include "entities/char_entity.h"
#include "lua/luautils.h"
#include "packets/s2c/0x073_chocobo_toteboard.h"
#include "packets/s2c/0x074_chocobo_list.h"

auto GP_CLI_COMMAND_CHOCOBO_RACE_REQ::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .mustEqual(PChar->getZone(), xi::ZoneId::ChocoboCircuit, "Not in Chocobo Circuit")
        .oneOf<GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND>(this->Kind);
}

void GP_CLI_COMMAND_CHOCOBO_RACE_REQ::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto board = luautils::callGlobal<sol::table>("xi.chocoboRacing.onRaceRequest", PChar, this->Param, this->Kind);
    if (board.empty())
    {
        return;
    }

    switch (static_cast<GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND>(this->Kind))
    {
        case GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND::ChocoboList:
        {
            // Mode 1: race parameters.
            PChar->pushPacket<GP_SERV_COMMAND_CHOCOBO_LIST::RACE>(board.get_or<uint32>("weather", 0));

            // Modes 2 & 3: entrant stats and names.
            if (const auto chocobos = board.get<sol::optional<sol::table>>("chocobos"))
            {
                const auto                                                count = std::min<size_t>(chocobos->size(), GP_SERV_COMMAND_CHOCOBO_LIST::kNumRacers);
                std::vector<GP_SERV_COMMAND_CHOCOBO_RACING::ChocoboParam> stats(count);
                std::vector<std::string>                                  names(count);

                for (size_t idx = 1; idx <= count; ++idx)
                {
                    const auto data = chocobos->get<sol::table>(idx);

                    stats[idx - 1] = GP_SERV_COMMAND_CHOCOBO_RACING::ChocoboParam::fromLua(data);
                    names[idx - 1] = data.get_or<std::string>("name", "");
                }

                PChar->pushPacket<GP_SERV_COMMAND_CHOCOBO_LIST::CHOCOBOS>(stats);
                PChar->pushPacket<GP_SERV_COMMAND_CHOCOBO_LIST::NAMES>(names);
            }

            // Mode 4: notify the client the exchange is done.
            PChar->pushPacket<GP_SERV_COMMAND_CHOCOBO_LIST::END>();
        }
        break;
        case GP_CLI_COMMAND_CHOCOBO_RACE_REQ_KIND::Toteboard:
        {
            std::vector<uint16_t> odds;
            if (const auto oddsTable = board.get<sol::optional<sol::table>>("odds"))
            {
                const auto count = std::min<size_t>(oddsTable->size(), GP_SERV_COMMAND_CHOCOBO_TOTEBOARD::kNumOdds);
                odds.reserve(count);
                for (size_t idx = 1; idx <= count; ++idx)
                {
                    odds.push_back(static_cast<uint16_t>(oddsTable->get_or<uint32>(idx, 0)));
                }
            }

            PChar->pushPacket<GP_SERV_COMMAND_CHOCOBO_TOTEBOARD>(this->Param, board.get_or<uint32>("grade", 0), board.get_or<uint32>("raceNumber", 0), odds);
        }
        break;
    }
}
