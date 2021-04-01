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
CTrait::CTrait(uint8 id)
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

        int32 ret = Sql_Query(SqlHandle, Query, MAX_TRAIT_ID);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                char* contentTag = nullptr;
                Sql_GetData(SqlHandle, 6, &contentTag, nullptr);

                if (!luautils::IsContentEnabled(contentTag))
                {
                    continue;
                }

                CTrait* PTrait = new CTrait(Sql_GetIntData(SqlHandle, 0));

                PTrait->setJob(Sql_GetIntData(SqlHandle, 1));
                PTrait->setLevel(Sql_GetIntData(SqlHandle, 2));
                PTrait->setRank(Sql_GetIntData(SqlHandle, 3));
                PTrait->setMod(static_cast<Mod>(Sql_GetIntData(SqlHandle, 4)));
                PTrait->setValue(Sql_GetIntData(SqlHandle, 5));
                PTrait->setMeritId(Sql_GetIntData(SqlHandle, 7));

                PTraitsList[PTrait->getJob()].push_back(PTrait);
            }
        }

        Query = "SELECT trait_category, trait_points_needed, traitid, modifier, value \
							 FROM blue_traits \
                             WHERE traitid < %u \
							 ORDER BY trait_category ASC, trait_points_needed DESC";

        ret = Sql_Query(SqlHandle, Query, MAX_TRAIT_ID);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                CBlueTrait* PTrait = new CBlueTrait(Sql_GetIntData(SqlHandle, 0), Sql_GetIntData(SqlHandle, 2));

                PTrait->setJob(JOB_BLU);
                PTrait->setRank(1);
                PTrait->setPoints(Sql_GetIntData(SqlHandle, 1));
                PTrait->setMod(static_cast<Mod>(Sql_GetIntData(SqlHandle, 3)));
                PTrait->setValue(Sql_GetIntData(SqlHandle, 4));

                PTraitsList[JOB_BLU].push_back(PTrait);
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
        XI_DEBUG_BREAK_IF(JobID >= MAX_JOBTYPE);

        return &PTraitsList[JobID];
    }
}; // namespace traits
