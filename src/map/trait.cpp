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
#include "map.h"
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
        const char* Query = "SELECT traitid, job, level, rank, modifier, value, content_tag, meritid \
                             FROM traits \
                             WHERE traitid < %u \
                             ORDER BY job, traitid ASC, rank DESC";

        int32 ret = sql->Query(Query, MAX_TRAIT_ID);

        if (ret != SQL_ERROR && sql->NumRows() != 0)
        {
            while (sql->NextRow() == SQL_SUCCESS)
            {
                char* contentTag = nullptr;
                sql->GetData(6, &contentTag, nullptr);

                if (!luautils::IsContentEnabled(contentTag))
                {
                    continue;
                }

                CTrait* PTrait = new CTrait(sql->GetIntData(0));

                PTrait->setJob(sql->GetIntData(1));
                PTrait->setLevel(sql->GetIntData(2));
                PTrait->setRank(sql->GetIntData(3));
                PTrait->setMod(static_cast<Mod>(sql->GetIntData(4)));
                PTrait->setValue(sql->GetIntData(5));
                PTrait->setMeritId(sql->GetIntData(7));

                PTraitsList[PTrait->getJob()].emplace_back(PTrait);
            }
        }

        Query = "SELECT trait_category, trait_points_needed, traitid, modifier, value \
                             FROM blue_traits \
                             WHERE traitid < %u \
                             ORDER BY trait_category ASC, trait_points_needed DESC";

        ret = sql->Query(Query, MAX_TRAIT_ID);

        if (ret != SQL_ERROR && sql->NumRows() != 0)
        {
            while (sql->NextRow() == SQL_SUCCESS)
            {
                CBlueTrait* PTrait = new CBlueTrait(sql->GetIntData(0), sql->GetIntData(2));

                PTrait->setJob(JOB_BLU);
                PTrait->setRank(1);
                PTrait->setPoints(sql->GetIntData(1));
                PTrait->setMod(static_cast<Mod>(sql->GetIntData(3)));
                PTrait->setValue(sql->GetIntData(4));

                PTraitsList[JOB_BLU].emplace_back(PTrait);
            }
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
