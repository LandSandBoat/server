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
#include "map_server.h"
#include "trait.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/
CTrait::CTrait(uint16 id)
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
        const char* Query = "SELECT traitid, job, level, rank, modifier, value, content_tag, meritid "
                            "FROM traits "
                            "WHERE traitid < %u "
                            "ORDER BY job, traitid ASC, rank DESC";

        auto rset = db::preparedStmt(Query, MAX_TRAIT_ID);

        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                // const auto contentTag = rset->getOrDefault<std::string>("content_tag", "");
                const auto contentTag = rset->get<std::string>(6);
                if (!luautils::IsContentEnabled(contentTag))
                {
                    continue;
                }

                CTrait* PTrait = new CTrait(rset->get<int32>(0));

                PTrait->setJob(rset->get<int32>(1));
                PTrait->setLevel(rset->get<int32>(2));
                PTrait->setRank(rset->get<int32>(3));
                PTrait->setMod(static_cast<Mod>(rset->get<int32>(4)));
                PTrait->setValue(rset->get<int32>(5));
                PTrait->setMeritId(rset->get<int32>(7));

                PTraitsList[PTrait->getJob()].emplace_back(PTrait);
            }
        }

        Query = "SELECT trait_category, trait_points_needed, traitid, modifier, value "
                "FROM blue_traits "
                "WHERE traitid < %u "
                "ORDER BY trait_category ASC, trait_points_needed DESC";

        rset = db::preparedStmt(Query, MAX_TRAIT_ID);

        if (rset && rset->rowsCount())
        {
            while (rset->next())
            {
                CBlueTrait* PTrait = new CBlueTrait(rset->get<int32>(0), rset->get<int32>(2));

                PTrait->setJob(JOB_BLU);
                PTrait->setRank(1);
                PTrait->setPoints(rset->get<int32>(1));
                PTrait->setMod(static_cast<Mod>(rset->get<int32>(3)));
                PTrait->setValue(rset->get<int32>(4));

                PTraitsList[JOB_BLU].emplace_back(PTrait);
            }
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
