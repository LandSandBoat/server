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

#pragma once

#include "common/cbasetypes.h"
#include "common/ipp.h"

#include <optional>
#include <unordered_map>

class CharacterCache
{
public:
    CharacterCache()  = default;
    ~CharacterCache() = default;

    void updateCharacter(uint32 charId, const IPP& ipp);
    void removeCharacter(uint32 charId);

    // TODO: Also handle lookup by name
    auto getCharacterIPP(uint32 charId) -> std::optional<IPP>;

private:
    std::unordered_map<uint32, IPP> charIdToIPP_;
};
