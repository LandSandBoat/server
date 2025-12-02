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

#include <cstring>

#include "lua/luautils.h"

#include "blue_trait.h"
#include "entities/battleentity.h"
#include "trait.h"

#include "map_engine.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/
CTrait::CTrait(const uint16 id)
: m_id(id)
{
}

/************************************************************************
 *                                                                       *
 *  Namespace for trait loading                                          *
 *                                                                       *
 ************************************************************************/
namespace traits
{

TraitList_t PTraitsList[MAX_JOBTYPE]; // Trait lists by job

/************************************************************************
 *                                                                       *
 *  LoadTraitList                                                        *
 *                                                                       *
 ************************************************************************/
void LoadTraitsList()
{
    auto rset = db::preparedStmt("SELECT traitid, job, level, rank, modifier, value, content_tag, meritid "
                                 "FROM traits "
                                 "WHERE traitid < ? "
                                 "ORDER BY job, traitid ASC, rank DESC",
                                 MAX_TRAIT_ID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        if (!luautils::IsContentEnabled(rset->getOrDefault<std::string>("content_tag", "")))
        {
            continue;
        }

        auto* PTrait = new CTrait(rset->get<uint16>("traitid"));

        PTrait->setJob(rset->get<int8>("job"));
        PTrait->setLevel(rset->get<uint8>("level"));
        PTrait->setRank(rset->get<uint8>("rank"));
        PTrait->setMod(rset->get<Mod>("modifier"));
        PTrait->setValue(rset->get<int16>("value"));
        PTrait->setMeritId(rset->get<uint32>("meritid"));

        PTraitsList[PTrait->getJob()].emplace_back(PTrait);
    }

    rset = db::preparedStmt("SELECT trait_category, trait_points_needed, traitid, modifier, value "
                            "FROM blue_traits "
                            "WHERE traitid < ? "
                            "ORDER BY trait_category ASC, trait_points_needed DESC",
                            MAX_TRAIT_ID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto* PTrait = new CBlueTrait(rset->get<uint8>("trait_category"), rset->get<uint8>("traitid"));

        PTrait->setJob(JOB_BLU);
        PTrait->setRank(1);
        PTrait->setPoints(rset->get<uint8>("trait_points_needed"));
        PTrait->setMod(rset->get<Mod>("modifier"));
        PTrait->setValue(rset->get<int16>("value"));

        PTraitsList[JOB_BLU].emplace_back(PTrait);
    }
}

void ClearTraitsList()
{
    // Manually cleanup traits list
    for (auto jobTraitList : PTraitsList)
    {
        for (auto trait : jobTraitList)
        {
            destroy(trait);
        }
        jobTraitList.clear();
    }
}
/************************************************************************
 *                                                                       *
 *  Get List of Traits by Main Job or Sub Job                            *
 *                                                                       *
 ************************************************************************/

TraitList_t* GetTraits(uint8 JobID)
{
    if (JobID >= MAX_JOBTYPE)
    {
        ShowWarning("JobID (%d) exceeds MAX_JOBTYPE.", JobID);
        return nullptr;
    }

    return &PTraitsList[JobID];
}

}; // namespace traits
