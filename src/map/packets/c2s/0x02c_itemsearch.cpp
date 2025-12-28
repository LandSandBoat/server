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

#include "entities/charentity.h"

auto GP_CLI_COMMAND_ITEMSEARCH::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // Not implemented.
    return PacketValidator()
        .oneOf<GP_CLI_COMMAND_ITEMSEARCH_LANGUAGE>(Language);
}

void GP_CLI_COMMAND_ITEMSEARCH::process(MapSession* PSession, CCharEntity* PChar) const
{
    ShowDebugFmt("GP_CLI_COMMAND_ITEMSEARCH: Not implemented. Language: {}, Name: {}",
                 Language,
                 asStringFromUntrustedSource(Name, sizeof(Name)));
}
