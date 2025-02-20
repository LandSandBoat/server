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
#include "map.h"
#include "packets/char_spells.h"
#include "utils/charutils.h"

CJobPoints::CJobPoints(CCharEntity* PChar)
{
    m_PChar = PChar;
    this->LoadJobPoints();
}

void CJobPoints::LoadJobPoints()
{
    if (
        _sql->Query("SELECT charid, jobid, capacity_points, job_points, job_points_spent, "
                    "jptype0, jptype1, jptype2, jptype3, jptype4, jptype5, jptype6, jptype7, jptype8, jptype9 "
                    "FROM char_job_points WHERE charid = %u ORDER BY jobid ASC",
                    m_PChar->id) != SQL_ERROR)
    {
        for (uint64 i = 0; i < _sql->NumRows(); i++)
        {
            if (_sql->NextRow() == SQL_SUCCESS)
            {
                uint32      jobId       = _sql->GetUIntData(1);
                uint16      jobCategory = JobPointsCategoryByJobId(jobId);
                JobPoints_t currentJob  = {};

                currentJob.jobId          = jobId;
                currentJob.jobCategory    = jobCategory;
                currentJob.capacityPoints = _sql->GetUIntData(2);
                currentJob.currentJp      = _sql->GetUIntData(3);
                currentJob.totalJpSpent   = _sql->GetUIntData(4);

                for (uint8 j = 0; j < JOBPOINTS_JPTYPE_PER_CATEGORY; j++)
                {
                    JobPointType_t currentType = {};
                    currentType.id             = currentJob.jobCategory + j;
                    currentType.value          = _sql->GetUIntData(JOBPOINTS_SQL_COLUMN_OFFSET + j);
                    std::memcpy(&currentJob.job_point_types[j], &currentType, sizeof(JobPointType_t));
                }

                std::memcpy(&m_jobPoints[jobId], &currentJob, sizeof(JobPoints_t));
            }
        }
    }
}

bool CJobPoints::IsJobPointExist(JOBPOINT_TYPE jpType)
{
    if ((static_cast<uint16>(jpType) < JOBPOINTS_CATEGORY_START) ||
        (JobPointsCategoryIndexByJpType(jpType) - 1 > JOBPOINTS_CATEGORY_COUNT) ||
        (JobPointTypeIndex(jpType) > JOBPOINTS_JPTYPE_PER_CATEGORY))
    {
        return false;
    }

    return true;
}

JobPoints_t* CJobPoints::GetJobPointsByType(JOBPOINT_TYPE jpType)
{
    if (IsJobPointExist(jpType))
    {
        return &m_jobPoints[JobPointsCategoryIndexByJpType(jpType)];
    }

    return nullptr;
}

JobPointType_t* CJobPoints::GetJobPointType(JOBPOINT_TYPE jpType)
{
    if (IsJobPointExist(jpType))
    {
        return &m_jobPoints[JobPointsCategoryIndexByJpType(jpType)].job_point_types[JobPointTypeIndex(jpType)];
    }

    return nullptr;
}

void CJobPoints::RaiseJobPoint(JOBPOINT_TYPE jpType)
{
    JobPoints_t*    job      = GetJobPointsByType(jpType);
    JobPointType_t* jobPoint = GetJobPointType(jpType);

    uint8 cost = JobPointCost(jobPoint->value);

    if (cost != 0 && job->currentJp >= cost)
    {
        job->currentJp -= cost;
        job->totalJpSpent += cost;
        jobPoint->value++;

        _sql->Query("UPDATE char_job_points SET jptype%u='%u', job_points='%u', job_points_spent='%u' WHERE charid='%u' AND jobid='%u'",
                    JobPointTypeIndex(jobPoint->id), jobPoint->value, job->currentJp, job->totalJpSpent, m_PChar->id, job->jobId);

        jobpointutils::RefreshGiftMods(m_PChar);
    }
}

uint16 CJobPoints::GetJobPoints()
{
    return m_jobPoints[m_PChar->GetMJob()].currentJp;
}

uint16 CJobPoints::GetJobPointsByJob(uint8 jobID)
{
    const char* Query = "SELECT job_points FROM char_job_points WHERE charid='%u' AND jobid='%u'";
    int         ret   = _sql->Query(Query, m_PChar->id, jobID);

    if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
    {
        return _sql->GetUIntData(0);
    }

    return 0;
}

void CJobPoints::SetJobPoints(int16 amount)
{
    uint8 currentJob = static_cast<uint8>(m_PChar->GetMJob());
    amount           = std::clamp<int16>(amount, 0, 500);

    _sql->Query("INSERT INTO char_job_points SET charid='%u', jobid='%u', job_points='%u' ON DUPLICATE KEY UPDATE job_points='%u'",
                m_PChar->id, currentJob, amount, amount);

    LoadJobPoints();
}

void CJobPoints::AddJobPoints(uint8 jobID, uint16 amount)
{
    if (jobID == 0 || jobID > 22)
    {
        ShowDebug("Attempt to adjust job points for an invalid job for (%s).", m_PChar->getName());
        return;
    }
    amount = std::clamp<int16>(amount, 0, 500);
    _sql->Query("INSERT INTO char_job_points SET charid='%u', jobid='%u', job_points='%d' ON DUPLICATE KEY UPDATE job_points=job_points +'%d'",
                m_PChar->id, jobID, amount, amount);

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

    _sql->Query("UPDATE char_job_points SET job_points='%u' WHERE charid='%u' AND jobid='%u'",
                currentAmount - amount, m_PChar->id, jobID);

    LoadJobPoints();
}

uint16 CJobPoints::GetJobPointsSpent()
{
    return m_jobPoints[m_PChar->GetMJob()].totalJpSpent;
}

JobPoints_t* CJobPoints::GetAllJobPoints()
{
    return m_jobPoints;
}

bool CJobPoints::AddCapacityPoints(uint16 amount)
{
    uint32 adjustedCapacity = m_jobPoints[m_PChar->GetMJob()].capacityPoints + amount * settings::get<float>("map.CAPACITY_RATE");
    uint16 currentJobPoints = this->GetJobPoints();

    if (adjustedCapacity >= 30000)
    {
        // check if player has reached cap
        if (currentJobPoints == 500)
        {
            this->SetCapacityPoints(30000 - 1);
            return false;
        }

        uint16 jobPoints = std::min((int)(currentJobPoints + adjustedCapacity / 30000), 500);

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

uint32 CJobPoints::GetCapacityPoints()
{
    return m_jobPoints[m_PChar->GetMJob()].capacityPoints;
}

void CJobPoints::SetCapacityPoints(uint16 amount)
{
    uint8 currentJob                       = static_cast<uint8>(m_PChar->GetMJob());
    amount                                 = std::clamp<int16>(amount, 0, 30000);
    m_jobPoints[currentJob].capacityPoints = amount;

    _sql->Query("INSERT INTO char_job_points SET charid='%u', jobid='%u', capacity_points='%u' ON DUPLICATE KEY UPDATE capacity_points='%u'",
                m_PChar->id, currentJob, amount, amount);
}

uint8 CJobPoints::GetJobPointValue(JOBPOINT_TYPE jpType)
{
    if (IsJobPointExist(jpType) && m_PChar->GetMLevel() >= 99 && m_PChar->GetMJob() == JobPointsCategoryIndexByJpType(jpType))
    {
        return GetJobPointType(jpType)->value;
    }

    return 0;
}

namespace jobpointutils
{
    std::vector<JobPointGifts_t> jpGifts[MAX_JOBTYPE] = {};

    void LoadGifts()
    {
        if (_sql->Query("SELECT jobid, jp_needed, modid, value FROM job_point_gifts ORDER BY jp_needed ASC") != SQL_ERROR)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                JobPointGifts_t gift = {};

                uint8 jobId     = _sql->GetUIntData(0);
                gift.jpRequired = _sql->GetUIntData(1);
                gift.modId      = _sql->GetUIntData(2);
                gift.value      = _sql->GetUIntData(3);

                jpGifts[jobId].emplace_back(gift);
            }
        }
    }

    void RefreshGiftMods(CCharEntity* PChar)
    {
        uint16 totalJpSpent = PChar->PJobPoints->GetJobPointsSpent();
        uint8  jobId        = static_cast<uint8>(PChar->GetMJob());

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
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, (uint16)SpellID::Fire_VI))
                {
                    for (const SpellID elementalSpell : { SpellID::Fire_VI,
                                                          SpellID::Blizzard_VI,
                                                          SpellID::Aero_VI,
                                                          SpellID::Stone_VI,
                                                          SpellID::Thunder_VI,
                                                          SpellID::Water_VI })
                    {
                        charutils::addSpell(PChar, (uint16)elementalSpell);
                        charutils::SaveSpell(PChar, (uint16)elementalSpell);
                    }

                    sendUpdate = true;
                }

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, (uint16)SpellID::Aspir_III))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Aspir_III);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Aspir_III);

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, (uint16)SpellID::Death))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Death);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Death);

                    sendUpdate = true;
                }
                break;

            case JOB_BRD:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, (uint16)SpellID::Fire_Threnody_II))
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
                        charutils::addSpell(PChar, (uint16)threnodySpell);
                        charutils::SaveSpell(PChar, (uint16)threnodySpell);
                    }

                    sendUpdate = true;
                }
                break;

            case JOB_DRK:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, (uint16)SpellID::Endark_II))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Endark_II);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Endark_II);

                    sendUpdate = true;
                }

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, (uint16)SpellID::Drain_III))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Drain_III);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Drain_III);

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
                        uint16 spellIdNum = static_cast<uint16>(elementalSpell);

                        if (!charutils::hasSpell(PChar, spellIdNum))
                        {
                            charutils::addSpell(PChar, spellIdNum);
                            charutils::SaveSpell(PChar, spellIdNum);
                        }
                    }

                    sendUpdate = true;
                }

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, (uint16)SpellID::Aspir_III))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Aspir_III);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Aspir_III);

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, (uint16)SpellID::Fira_III))
                {
                    for (const SpellID elementalSpell : { SpellID::Fira_III,
                                                          SpellID::Blizzara_III,
                                                          SpellID::Aera_III,
                                                          SpellID::Stonera_III,
                                                          SpellID::Thundara_III,
                                                          SpellID::Watera_III })
                    {
                        charutils::addSpell(PChar, (uint16)elementalSpell);
                        charutils::SaveSpell(PChar, (uint16)elementalSpell);
                    }

                    sendUpdate = true;
                }
                break;

            case JOB_NIN:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, (uint16)SpellID::Utsusemi_San))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Utsusemi_San);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Utsusemi_San);

                    sendUpdate = true;
                }
                break;

            case JOB_PLD:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, (uint16)SpellID::Enlight_II))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Enlight_II);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Enlight_II);

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

                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, (uint16)SpellID::Addle_II))
                {
                    for (const SpellID enfeeblingSpell : { SpellID::Addle_II,
                                                           SpellID::Distract_III,
                                                           SpellID::Frazzle_III })
                    {
                        charutils::addSpell(PChar, (uint16)enfeeblingSpell);
                        charutils::SaveSpell(PChar, (uint16)enfeeblingSpell);
                    }

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, (uint16)SpellID::Refresh_III))
                {
                    for (const SpellID enfeeblingSpell : { SpellID::Refresh_III,
                                                           SpellID::Temper_II })
                    {
                        charutils::addSpell(PChar, (uint16)enfeeblingSpell);
                        charutils::SaveSpell(PChar, (uint16)enfeeblingSpell);
                    }

                    sendUpdate = true;
                }
                break;

            case JOB_RUN:
                if (totalJpSpent >= 550 && !charutils::hasSpell(PChar, (uint16)SpellID::Temper))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Temper);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Temper);

                    sendUpdate = true;
                }
                break;

            case JOB_WHM:
                if (totalJpSpent >= 100 && !charutils::hasSpell(PChar, (uint16)SpellID::Reraise_IV))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Reraise_IV);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Reraise_IV);

                    sendUpdate = true;
                }

                if (totalJpSpent >= 1200 && !charutils::hasSpell(PChar, (uint16)SpellID::Full_Cure))
                {
                    charutils::addSpell(PChar, (uint16)SpellID::Full_Cure);
                    charutils::SaveSpell(PChar, (uint16)SpellID::Full_Cure);

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
