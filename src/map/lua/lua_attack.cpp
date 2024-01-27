/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "lua_attack.h"

#include "attack.h"

CLuaAttack::CLuaAttack(CAttack* attack)
: m_PLuaAttack(attack)
{
    if (m_PLuaAttack == nullptr)
    {
        ShowError("CLuaAttack created with nullptr instead of valid CAttack*!");
    }
}

bool CLuaAttack::getCritical() const
{
    return m_PLuaAttack->IsCritical();
}

void CLuaAttack::setCritical(bool critical)
{
    m_PLuaAttack->SetCritical(critical);
}

//==========================================================//

void CLuaAttack::Register()
{
    SOL_USERTYPE("CAttack", CLuaAttack);
    SOL_REGISTER("getCritical", CLuaAttack::getCritical);
    SOL_REGISTER("setCritical", CLuaAttack::setCritical);
};

std::ostream& operator<<(std::ostream& os, const CLuaAttack& attack)
{
    // TODO: Whats a sane log value for this?
    std::string id = attack.m_PLuaAttack ? "" : "nullptr";
    return os << "CLuaAttack(" << id << ")";
}

//==========================================================//
