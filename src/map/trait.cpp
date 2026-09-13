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

#include "trait.h"

#include "blue_trait.h"
#include "data/datasets/traits/dataset.h"
#include "lua/luautils.h"
#include "utils/dataset_loader.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/
CTrait::CTrait(const uint16 id)
: m_id(static_cast<xi::Trait>(id))
{
}

/************************************************************************
 *                                                                       *
 *  Namespace for trait loading                                          *
 *                                                                       *
 ************************************************************************/
namespace traits
{

namespace
{

TraitList_t PTraitsList[MAX_JOBTYPE]; // Trait lists by job

} // namespace

/************************************************************************
 *                                                                       *
 *  LoadTraitList                                                        *
 *                                                                       *
 ************************************************************************/
void LoadTraitsList()
{
    const auto records = xi::data::loadDataset<xi::data::datasets::traits::Dataset>();

    for (const auto& entry : records)
    {
        if (!luautils::IsContentEnabled(entry.Content))
        {
            continue;
        }

        auto* PTrait = new CTrait(std::to_underlying(entry.Id));

        PTrait->setJob(static_cast<int8>(entry.Job));
        PTrait->setLevel(entry.Level);
        PTrait->setRank(entry.Rank);
        PTrait->setMod(entry.Mod);
        PTrait->setValue(entry.Value);
        PTrait->setMeritId(std::to_underlying(entry.Merit));

        PTraitsList[static_cast<uint8>(entry.Job)].emplace_back(PTrait);
    }

    auto rset = db::preparedStmt("SELECT trait_category, trait_points_needed, traitid, modifier, value, tier, job_points_only "
                                 "FROM blue_traits "
                                 "WHERE traitid < ? "
                                 "ORDER BY tier ASC",
                                 MAX_TRAIT_ID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto* PTrait = new CBlueTrait(rset->get<uint8>("trait_category"), rset->get<uint8>("traitid"), rset->get<bool>("job_points_only"));

        PTrait->setJob(static_cast<int8>(xi::Job::BLU));
        PTrait->setRank(rset->get<uint8>("tier"));
        PTrait->setPoints(rset->get<uint8>("trait_points_needed"));
        PTrait->setMod(rset->get<xi::Mod>("modifier"));
        PTrait->setValue(rset->get<int16>("value"));

        PTraitsList[static_cast<uint8>(xi::Job::BLU)].emplace_back(PTrait);
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

auto GetTraits(xi::Job JobID) -> TraitList_t*
{
    if (static_cast<uint8>(JobID) >= MAX_JOBTYPE)
    {
        ShowWarning("JobID (%d) exceeds MAX_JOBTYPE.", static_cast<uint8>(JobID));
        return nullptr;
    }

    return &PTraitsList[static_cast<uint8>(JobID)];
}

}; // namespace traits
