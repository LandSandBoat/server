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

#include "0x02c_itemsearch.h"

#include "entities/char_entity.h"
#include "packets/s2c/0x049_itemsearch.h"
#include "utils/itemutils.h"

auto GP_CLI_COMMAND_ITEMSEARCH::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator(PChar)
        .blockedBy({ BlockedState::InEvent })
        .oneOf<GP_CLI_COMMAND_ITEMSEARCH_LANGUAGE>(this->Language);
}

void GP_CLI_COMMAND_ITEMSEARCH::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto inputName = asStringFromUntrustedSource(this->Name, sizeof(this->Name));

    // Same-language lookup against the translate map.
    const auto fromTo = static_cast<GP_CLI_COMMAND_TRANSLATE_INDEX>(this->Language);
    const auto result = itemutils::TranslateItemName(fromTo, fromTo, inputName);
    const auto itemId = result.has_value() ? result->first : static_cast<uint16>(0);

    PChar->pushPacket<GP_SERV_COMMAND_ITEMSEARCH>(itemId, inputName);
}
