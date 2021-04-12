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

CJobPoints::CJobPoints(CCharEntity* PChar)
{
    m_PChar = PChar;
    this->LoadJobPoints();
}

void CJobPoints::LoadJobPoints()
{
    memset(m_jobPoints, 0, sizeof(m_jobPoints));
    if (
        Sql_Query(SqlHandle, "SELECT charid, jobid, capacity_points, job_points, job_points_spent, "
                             "jptype0, jptype1, jptype2, jptype3, jptype4, jptype5, jptype6, jptype7, jptype8, jptype9 "
                             "FROM char_job_points WHERE charid = %u ORDER BY jobid ASC",
                  m_PChar->id) != SQL_ERROR)
    {
        for (uint8 i = 0; i < Sql_NumRows(SqlHandle); i++)
        {
            if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                uint32      jobId       = Sql_GetUIntData(SqlHandle, 1);
                uint16      jobCategory = JobPointsCategoryByJobId(jobId);
                JobPoints_t currentJob  = {};

                currentJob.jobId          = jobId;
                currentJob.jobCategory    = jobCategory;
                currentJob.capacityPoints = Sql_GetUIntData(SqlHandle, 2);
                currentJob.currentJp      = Sql_GetUIntData(SqlHandle, 3);
                currentJob.totalJpSpent   = Sql_GetUIntData(SqlHandle, 4);

                for (uint8 j = 0; j < JOBPOINTS_JPTYPE_PER_CATEGORY; j++)
                {
                    JobPointType_t currentType = {};
                    currentType.id             = currentJob.jobCategory + j;
                    currentType.value          = Sql_GetUIntData(SqlHandle, JOBPOINTS_SQL_COLUMN_OFFSET + j);
                    memcpy(&currentJob.job_point_types[j], &currentType, sizeof(JobPointType_t));
                }

                memcpy(&m_jobPoints[jobId], &currentJob, sizeof(JobPoints_t));
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

        Sql_Query(SqlHandle, "UPDATE char_job_points SET jptype%u='%u', job_points='%u', job_points_spent='%u' WHERE charid='%u' AND jobid='%u'",
                  JobPointTypeIndex(jobPoint->id), jobPoint->value, job->currentJp, job->totalJpSpent, m_PChar->id, job->jobId);

        jobpointutils::RefreshGiftMods(m_PChar);
    }
}

uint16 CJobPoints::GetJobPoints()
{
    return m_jobPoints[m_PChar->GetMJob()].currentJp;
}

void CJobPoints::SetJobPoints(int16 amount)
{
    uint8 currentJob = static_cast<uint8>(m_PChar->GetMJob());
    amount           = std::clamp<int16>(amount, 0, 500);

    Sql_Query(SqlHandle, "INSERT INTO char_job_points SET charid='%u', jobid='%u', job_points='%u' ON DUPLICATE KEY UPDATE job_points='%u'",
              m_PChar->id, currentJob, amount, amount);

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
    uint32 adjustedCapacity = m_jobPoints[m_PChar->GetMJob()].capacityPoints + amount;
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

    Sql_Query(SqlHandle, "INSERT INTO char_job_points SET charid='%u', jobid='%u', capacity_points='%u' ON DUPLICATE KEY UPDATE capacity_points='%u'",
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
        if (Sql_Query(SqlHandle, "SELECT jobid, jp_needed, modid, value FROM job_point_gifts ORDER BY jp_needed ASC") != SQL_ERROR)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                JobPointGifts_t gift = {};

                uint8 jobId     = Sql_GetUIntData(SqlHandle, 0);
                gift.jpRequired = Sql_GetUIntData(SqlHandle, 1);
                gift.modId      = Sql_GetUIntData(SqlHandle, 2);
                gift.value      = Sql_GetUIntData(SqlHandle, 3);

                jpGifts[jobId].push_back(gift);
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

            currentGifts->push_back(CModifier(static_cast<Mod>(gift.modId), gift.value));
        }

        PChar->addModifiers(currentGifts);
    }
} // namespace jobpointutils
