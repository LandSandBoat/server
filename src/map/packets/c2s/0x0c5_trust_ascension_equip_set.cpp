/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "0x0c5_trust_ascension_equip_set.h"

#include "packets/c2s/validation.h"

auto GP_CLI_COMMAND_TRUST_ASCENSION_EQUIP_SET::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // TODO: Trust equipment is not implemented.
    return PacketValidator(PChar);
}

void GP_CLI_COMMAND_TRUST_ASCENSION_EQUIP_SET::process(MapSession* PSession, CCharEntity* PChar) const
{
}
