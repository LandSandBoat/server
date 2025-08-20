/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
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

#include <string.h>

#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "job_points.h"

#include "map_engine.h"
#include "packets/char_spells.h"
#include "spell.h"
#include "utils/charutils.h"

namespace
{
    uint8 categoryStart = 0x020;
    uint8 categoryCount = 22;

    auto JobPointsCategoryByJobId = [](const uint8 jobId) -> uint16
    {
        return categoryStart * jobId;
    };

    auto JobPointsCategoryIndexByJpType = [](JobPointType jpType) -> uint16
    {
        return static_cast<uint16>(jpType) >> 5;
    };

    auto JobPointTypeIndex = [](JobPointType id) -> uint16
    {
        return static_cast<uint16>(id) & 0x1F;
    };

    auto JobPointCost = [](const uint16 value) -> uint16
    {
        return (value + 1) % 21;
    };

} // namespace

CJobPoints::CJobPoints(CCharEntity* PChar)
{
    m_PChar = PChar;
    this->LoadJobPoints();
}

void CJobPoints::LoadJobPoints()
{
    const auto query = "SELECT charid, jobid, capacity_points, job_points, job_points_spent, "
                       "jptype0, jptype1, jptype2, jptype3, jptype4, jptype5, jptype6, jptype7, jptype8, jptype9 "
                       "FROM char_job_points WHERE charid = ? ORDER BY jobid ASC";

    const auto rset = db::preparedStmt(query, m_PChar->id);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto   jobId       = rset->get<uint16>("jobid");
        const uint16 jobCategory = JobPointsCategoryByJobId(jobId);
        JobPoints_t  currentJob  = {};

        currentJob.jobId          = jobId;
        currentJob.jobCategory    = jobCategory;
        currentJob.capacityPoints = rset->get<uint16>("capacity_points");
        currentJob.currentJp      = rset->get<uint16>("job_points");
        currentJob.totalJpSpent   = rset->get<uint16>("job_points_spent");

        for (uint8 j = 0; j < jpTypePerCategory; j++)
        {
            JobPointType_t currentType = {};
            currentType.id             = currentJob.jobCategory + j;
            std::string columnName     = fmt::format("jptype{}", j);
            currentType.value          = rset->get<uint8>(columnName);
            std::memcpy(&currentJob.job_point_types[j], &currentType, sizeof(JobPointType_t));
        }

        std::memcpy(&m_jobPoints[jobId], &currentJob, sizeof(JobPoints_t));
    }
}

auto CJobPoints::IsJobPointExist(const JobPointType jpType) const -> bool
{
    if ((static_cast<uint16>(jpType) < categoryStart) ||
        (JobPointsCategoryIndexByJpType(jpType) - 1 > categoryCount) ||
        (JobPointTypeIndex(jpType) > jpTypePerCategory))
    {
        return false;
    }

    return true;
}

auto CJobPoints::GetJobPointsByType(const JobPointType jpType) -> JobPoints_t*
{
    if (IsJobPointExist(jpType))
    {
        return &m_jobPoints[JobPointsCategoryIndexByJpType(jpType)];
    }

    return nullptr;
}

auto CJobPoints::GetJobPointType(const JobPointType jpType) -> JobPointType_t*
{
    if (IsJobPointExist(jpType))
    {
        return &m_jobPoints[JobPointsCategoryIndexByJpType(jpType)].job_point_types[JobPointTypeIndex(jpType)];
    }

    return nullptr;
}

void CJobPoints::RaiseJobPoint(const JobPointType jpType)
{
    JobPoints_t*    job      = GetJobPointsByType(jpType);
    JobPointType_t* jobPoint = GetJobPointType(jpType);

    const uint8 cost = JobPointCost(jobPoint->value);

    if (cost != 0 && job->currentJp >= cost)
    {
        job->currentJp -= cost;
        job->totalJpSpent += cost;
        jobPoint->value++;

        const auto updateQuery = fmt::format("UPDATE char_job_points "
                                             "SET jptype{} = ?, job_points = ?, job_points_spent = ? "
                                             "WHERE charid = ? AND jobid = ?",
                                             JobPointTypeIndex(static_cast<JobPointType>(jobPoint->id)));
        db::preparedStmt(updateQuery, jobPoint->value, job->currentJp, job->totalJpSpent, m_PChar->id, job->jobId);

        jobpointutils::RefreshGiftMods(m_PChar);
    }
}

auto CJobPoints::GetJobPoints() const -> uint16
{
    return m_jobPoints[m_PChar->GetMJob()].currentJp;
}

auto CJobPoints::GetJobPointsByJob(uint8 jobID) const -> uint16
{
    const auto query = "SELECT job_points "
                       "FROM char_job_points "
                       "WHERE charid = ? AND jobid = ?";
    const auto rset  = db::preparedStmt(query, m_PChar->id, jobID);
    FOR_DB_SINGLE_RESULT(rset)
    {
        return rset->get<uint16>("job_points");
    }

    return 0;
}

void CJobPoints::SetJobPoints(int16 amount)
{
    uint8 currentJob = m_PChar->GetMJob();
    amount           = std::clamp<int16>(amount, 0, 500);

    const auto insertQuery = "INSERT INTO char_job_points "
                             "SET charid = ?, jobid = ?, job_points = ? "
                             "ON DUPLICATE KEY UPDATE job_points = ?";
    db::preparedStmt(insertQuery, m_PChar->id, currentJob, amount, amount);

    LoadJobPoints();
}

void CJobPoints::AddJobPoints(uint8 jobID, uint16 amount)
{
    if (jobID == 0 || jobID > 22)
    {
        ShowDebug("Attempt to adjust job points for an invalid job for (%s).", m_PChar->getName());
        return;
    }
    amount              = std::clamp<int16>(amount, 0, 500);
    const auto addQuery = "INSERT INTO char_job_points SET charid=?, jobid=?, job_points=? ON DUPLICATE KEY UPDATE job_points=job_points+?";
    db::preparedStmt(addQuery, m_PChar->id, jobID, amount, amount);

    LoadJobPoints();
}

void CJobPoints::DelJobPoints(uint8 jobID, int16 amount)
{
    int16 currentAmount = GetJobPointsByJob(jobID);
    amount              = std::clamp<int16>(amount, -500, 500);
    if (currentAmount < amount)
    {
        ShowDebug("Attempt to reduce job points below 0 for (%s).", m_PChar->getName());
        return;
    }

    const auto updateQuery = "UPDATE char_job_points SET job_points=? WHERE charid=? AND jobid=?";
    db::preparedStmt(updateQuery, currentAmount - amount, m_PChar->id, jobID);

    LoadJobPoints();
}

auto CJobPoints::GetJobPointsSpent() const -> uint16
{
    return m_jobPoints[m_PChar->GetMJob()].totalJpSpent;
}

auto CJobPoints::GetAllJobPoints() -> JobPoints_t*
{
    return m_jobPoints;
}

auto CJobPoints::AddCapacityPoints(const uint16 amount) -> bool
{
    const uint32 adjustedCapacity = m_jobPoints[m_PChar->GetMJob()].capacityPoints + amount * settings::get<float>("map.CAPACITY_RATE");
    const uint16 currentJobPoints = this->GetJobPoints();

    if (adjustedCapacity >= 30000)
    {
        // check if player has reached cap
        if (currentJobPoints == 500)
        {
            this->SetCapacityPoints(30000 - 1);
            return false;
        }

        const uint16 jobPoints = std::min(static_cast<int>(currentJobPoints + adjustedCapacity / 30000), 500);

        this->SetCapacityPoints(adjustedCapacity % 30000);

        if (currentJobPoints != jobPoints)
        {
            this->SetJobPoints(jobPoints);
            return true;
        }
    }
    else
    {
        this->SetCapacityPoints(adjustedCapacity);
    }

    return false;
}

auto CJobPoints::GetCapacityPoints() const -> uint32
{
    return m_jobPoints[m_PChar->GetMJob()].capacityPoints;
}

void CJobPoints::SetCapacityPoints(uint16 amount)
{
    uint8 currentJob                       = static_cast<uint8>(m_PChar->GetMJob());
    amount                                 = std::clamp<int16>(amount, 0, 30000);
    m_jobPoints[currentJob].capacityPoints = amount;

    const auto insertCapQuery = "INSERT INTO char_job_points SET charid=?, jobid=?, capacity_points=? ON DUPLICATE KEY UPDATE capacity_points=?";
    db::preparedStmt(insertCapQuery, m_PChar->id, currentJob, amount, amount);
}

auto CJobPoints::GetJobPointValue(const JobPointType jpType) -> uint8
{
    if (IsJobPointExist(jpType) && m_PChar->GetMLevel() >= 99 && m_PChar->GetMJob() == JobPointsCategoryIndexByJpType(jpType))
    {
        return GetJobPointType(jpType)->value;
    }

    return 0;
}

auto JobPointType_t::cost() const -> uint8
{
    return (value + 1) % 21;
}

auto JobPointType_t::format() const -> uint8
{
    return (value << 2);
}

namespace jobpointutils
{
    std::vector<JobPointGifts_t> jpGifts[MAX_JOBTYPE] = {};

    void LoadGifts()
    {
        const auto query = "SELECT jobid, jp_needed, modid, value FROM job_point_gifts ORDER BY jp_needed ASC";
        const auto rset  = db::preparedStmt(query);
        FOR_DB_MULTIPLE_RESULTS(rset)
        {
            JobPointGifts_t gift = {};

            const uint8 jobId = rset->get<uint8>("jobid");
            gift.jpRequired   = rset->get<uint32>("jp_needed");
            gift.modId        = rset->get<uint32>("modid");
            gift.value        = rset->get<uint32>("value");

            jpGifts[jobId].emplace_back(gift);
        }
    }

    void RefreshGiftMods(CCharEntity* PChar)
    {
        const uint16 totalJpSpent = PChar->PJobPoints->GetJobPointsSpent();
        const uint8  jobId        = static_cast<uint8>(PChar->GetMJob());

        auto* currentGifts = &PChar->PJobPoints->current_gifts;
        if (!currentGifts->empty())
        {
            PChar->delModifiers(currentGifts);
            currentGifts->clear();
        }

        for (auto&& gift : jpGifts[jobId])
        {
            if (gift.jpRequired > totalJpSpent || PChar->GetMLevel() < 99)
            {
                break;
            }

            currentGifts->emplace_back(static_cast<Mod>(gift.modId), gift.value);
        }

        PChar->addModifiers(currentGifts);

        // Add JP Spells
        bool sendUpdate = false;
        switch (jobId)
        {
            case JOB_BLM:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Fire_VI)))
                {
                    for (const SpellID elementalSpell : { SpellID::Fire_VI,
                                                          SpellID::Blizzard_VI,
                                                          SpellID::Aero_VI,
                                                          SpellID::Stone_VI,
                                                          SpellID::Thunder_VI,
                                                          SpellID::Water_VI })
                    {
                        charutils::addSpell(PChar, static_cast<uint16>(elementalSpell));
                        charutils::SaveSpell(PChar, static_cast<uint16>(elementalSpell));
                    }

                    sendUpdate = true;
                }

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Aspir_III)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Aspir_III));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Aspir_III));

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Death)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Death));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Death));

                    sendUpdate = true;
                }
                break;

            case JOB_BRD:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Fire_Threnody_II)))
                {
                    for (const SpellID threnodySpell : { SpellID::Fire_Threnody_II,
                                                         SpellID::Ice_Threnody_II,
                                                         SpellID::Wind_Threnody_II,
                                                         SpellID::Earth_Threnody_II,
                                                         SpellID::Lightning_Threnody_II,
                                                         SpellID::Water_Threnody_II,
                                                         SpellID::Light_Threnody_II,
                                                         SpellID::Dark_Threnody_II })
                    {
                        charutils::addSpell(PChar, static_cast<uint16>(threnodySpell));
                        charutils::SaveSpell(PChar, static_cast<uint16>(threnodySpell));
                    }

                    sendUpdate = true;
                }
                break;

            case JOB_DRK:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Endark_II)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Endark_II));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Endark_II));

                    sendUpdate = true;
                }

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Drain_III)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Drain_III));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Drain_III));

                    sendUpdate = true;
                }
                break;

            case JOB_GEO:
                if (totalJpSpent >= 100)
                {
                    for (const SpellID elementalSpell : { SpellID::Fire_V,
                                                          SpellID::Blizzard_V,
                                                          SpellID::Aero_V,
                                                          SpellID::Stone_V,
                                                          SpellID::Thunder_V,
                                                          SpellID::Water_V })
                    {
                        const uint16 spellIdNum = static_cast<uint16>(elementalSpell);

                        if (!charutils::hasSpell(PChar, spellIdNum))
                        {
                            charutils::addSpell(PChar, spellIdNum);
                            charutils::SaveSpell(PChar, spellIdNum);
                        }
                    }

                    sendUpdate = true;
                }

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Aspir_III)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Aspir_III));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Aspir_III));

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Fira_III)))
                {
                    for (const SpellID elementalSpell : { SpellID::Fira_III,
                                                          SpellID::Blizzara_III,
                                                          SpellID::Aera_III,
                                                          SpellID::Stonera_III,
                                                          SpellID::Thundara_III,
                                                          SpellID::Watera_III })
                    {
                        charutils::addSpell(PChar, static_cast<uint16>(elementalSpell));
                        charutils::SaveSpell(PChar, static_cast<uint16>(elementalSpell));
                    }

                    sendUpdate = true;
                }
                break;

            case JOB_NIN:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Utsusemi_San)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Utsusemi_San));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Utsusemi_San));

                    sendUpdate = true;
                }
                break;

            case JOB_PLD:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Enlight_II)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Enlight_II));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Enlight_II));

                    sendUpdate = true;
                }
                break;

            case JOB_RDM:
                if (totalJpSpent >= 100)
                {
                    for (const SpellID elementalSpell : { SpellID::Fire_V,
                                                          SpellID::Blizzard_V,
                                                          SpellID::Aero_V,
                                                          SpellID::Stone_V,
                                                          SpellID::Thunder_V,
                                                          SpellID::Water_V })
                    {
                        uint16 spellIdNum = static_cast<uint16>(elementalSpell);

                        if (!charutils::hasSpell(PChar, spellIdNum))
                        {
                            charutils::addSpell(PChar, spellIdNum);
                            charutils::SaveSpell(PChar, spellIdNum);
                        }
                    }

                    sendUpdate = true;
                }

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Addle_II)))
                {
                    for (const SpellID enfeeblingSpell : { SpellID::Addle_II,
                                                           SpellID::Distract_III,
                                                           SpellID::Frazzle_III })
                    {
                        charutils::addSpell(PChar, static_cast<uint16>(enfeeblingSpell));
                        charutils::SaveSpell(PChar, static_cast<uint16>(enfeeblingSpell));
                    }

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Refresh_III)))
                {
                    for (const SpellID enfeeblingSpell : { SpellID::Refresh_III,
                                                           SpellID::Temper_II })
                    {
                        charutils::addSpell(PChar, static_cast<uint16>(enfeeblingSpell));
                        charutils::SaveSpell(PChar, static_cast<uint16>(enfeeblingSpell));
                    }

                    sendUpdate = true;
                }
                break;

            case JOB_RUN:
                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Temper)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Temper));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Temper));

                    sendUpdate = true;
                }
                break;

            case JOB_WHM:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Reraise_IV)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Reraise_IV));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Reraise_IV));

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, static_cast<uint16>(SpellID::Full_Cure)))
                {
                    charutils::addSpell(PChar, static_cast<uint16>(SpellID::Full_Cure));
                    charutils::SaveSpell(PChar, static_cast<uint16>(SpellID::Full_Cure));

                    sendUpdate = true;
                }
                break;
        }

        if (sendUpdate)
        {
            PChar->pushPacket<CCharSpellsPacket>(PChar);
        }
    }
} // namespace jobpointutils
