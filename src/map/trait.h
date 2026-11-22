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

#pragma once

#include "common/cbasetypes.h"
#include "common/macros.h"
#include "data/enums/job.h"
#include "data/enums/merit.h"
#include "data/enums/trait.h"

#include "modifier.h"

#define MAX_TRAIT_ID 139

class CTrait
{
public:
    CTrait(uint16 id);
    virtual ~CTrait() = default;

    DISALLOW_COPY_AND_MOVE(CTrait);

    auto getID() const -> xi::Trait
    {
        return m_id;
    }

    auto getJob() const -> xi::Job
    {
        return m_job;
    }

    auto getLevel() const -> uint8
    {
        return m_level;
    }

    auto getMod() const -> xi::Mod
    {
        return m_mod;
    }

    auto getValue() const -> int16
    {
        return m_value;
    }

    auto getRank() const -> uint8
    {
        return m_rank;
    }

    auto getMerit() const -> xi::Merit
    {
        return m_merit;
    }

    void setJob(const xi::Job job)
    {
        m_job = job;
    }

    void setLevel(const uint8 level)
    {
        m_level = level;
    }

    void setMod(const xi::Mod mod)
    {
        m_mod = mod;
    }

    void setValue(const int16 value)
    {
        m_value = value;
    }

    void setRank(const uint8 rank)
    {
        m_rank = rank;
    }

    void setMerit(const xi::Merit merit)
    {
        m_merit = merit;
    }

private:
    xi::Trait m_id{};
    xi::Job   m_job{};
    uint8     m_level{ 0 };
    xi::Mod   m_mod{ xi::Mod::NONE };
    int16     m_value{ 0 };
    uint8     m_rank{ 0 };
    xi::Merit m_merit{};
};

using TraitList_t = std::vector<CTrait*>;

namespace traits
{

void LoadTraitsList();
void ClearTraitsList();

auto GetTraits(xi::Job JobID) -> TraitList_t*;

}; // namespace traits
