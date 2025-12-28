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

#include "messageutils.h"

#include "enums/msg_basic.h"

namespace messageutils
{
auto GetAoEVariant(const MsgBasic primary) -> MsgBasic
{
    const auto it = aoeVariants.find(primary);
    return it != aoeVariants.end() ? it->second : primary;
}

auto GetAbsorbVariant(const MsgBasic primary) -> MsgBasic
{
    const auto it = absorbVariants.find(primary);
    return it != absorbVariants.end() ? it->second : primary;
}
} // namespace messageutils
