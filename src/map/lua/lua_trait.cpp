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

#include "lua_trait.h"
#include "trait.h"

CLuaTrait::CLuaTrait(CTrait* PTrait)
: trait_(PTrait)
{
    if (PTrait == nullptr)
    {
        ShowError("CLuaTrait created with nullptr instead of valid CTrait*!");
    }
}

auto CLuaTrait::getID() const -> uint16
{
    return trait_->getID();
}

auto CLuaTrait::getJob() const -> uint8
{
    return trait_->getJob();
}

auto CLuaTrait::getLevel() const -> uint8
{
    return trait_->getLevel();
}

auto CLuaTrait::getMod() const -> xi::Mod
{
    return trait_->getMod();
}

auto CLuaTrait::getValue() const -> int16
{
    return trait_->getValue();
}

auto CLuaTrait::getRank() const -> uint8
{
    return trait_->getRank();
}

auto CLuaTrait::getMeritID() const -> uint32
{
    return trait_->getMeritID();
}

//==========================================================//

void CLuaTrait::Register()
{
    SOL_USERTYPE("CTrait", CLuaTrait);
    SOL_REGISTER("getID", CLuaTrait::getID);
    SOL_REGISTER("getJob", CLuaTrait::getJob);
    SOL_REGISTER("getLevel", CLuaTrait::getLevel);
    SOL_REGISTER("getMod", CLuaTrait::getMod);
    SOL_REGISTER("getValue", CLuaTrait::getValue);
    SOL_REGISTER("getRank", CLuaTrait::getRank);
    SOL_REGISTER("getMeritID", CLuaTrait::getMeritID);
}

auto operator<<(std::ostream& os, const CLuaTrait& trait) -> std::ostream&
{
    const std::string id = trait.trait_ ? std::to_string(trait.trait_->getID()) : "nullptr";
    return os << "CLuaTrait(" << id << ")";
}

//==========================================================//
