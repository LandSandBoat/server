/*
===========================================================================
  Copyright (c) 2010-2015 Darkstar Dev Teams
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

#ifndef _CMODIFIER_H
#define _CMODIFIER_H

#include "common/cbasetypes.h"
#include "data/enums/mod.h"

// temporary workaround for using enum class as unordered_map key until compilers support it
struct EnumClassHash
{
    template <typename T>
    std::size_t operator()(T t) const
    {
        return static_cast<std::size_t>(t);
    }
};

/************************************************************************
 *  Modifier Class                                                       *
 ************************************************************************/

class CModifier
{
public:
    xi::Mod getModID() const;
    int16   getModAmount() const;

    void setModAmount(int16 amount);

    CModifier(xi::Mod type, int16 amount = 0);

private:
    xi::Mod m_id{ xi::Mod::NONE };
    int16   m_amount{ 0 };
};

enum class PetModType
{
    All        = 0,
    Avatar     = 1,
    Wyvern     = 2,
    Automaton  = 3,
    Harlequin  = 4,
    Valoredge  = 5,
    Sharpshot  = 6,
    Stormwaker = 7,
    Luopan     = 8
};

class CPetModifier : public CModifier
{
public:
    CPetModifier(xi::Mod type, PetModType pettype, int16 amount = 0);
    PetModType getPetModType() const;

private:
    PetModType m_pettype{ PetModType::All };
};

#endif
