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
#include "utils/charutils.h"

CJobPoints::CJobPoints(CCharEntity* PChar)
{
    jp_PChar = PChar;
    this->LoadJobPoints();
}

void CJobPoints::LoadJobPoints()
{
    memset(job_points, 0, sizeof(job_points));
    if (
        Sql_Query(SqlHandle, "SELECT charid, jobid, capacity_points, job_points, job_points_spent, "
                             "jptype0, jptype1, jptype2, jptype3, jptype4, jptype5, jptype6, jptype7, jptype8, jptype9 "
                             "FROM char_job_points WHERE charid = %u ORDER BY jobid ASC",
                  jp_PChar->id) != SQL_ERROR)
    {
        for (uint8 i = 0; i < Sql_NumRows(SqlHandle); i++)
        {
            if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                uint32      jobid            = Sql_GetUIntData(SqlHandle, 1);
                uint16      job_category     = JobPointsCategoryByJobId(jobid);
                JobPoints_t current_job      = {};
                current_job.jobid            = jobid;
                current_job.job_category     = job_category;
                current_job.capacity_points  = Sql_GetUIntData(SqlHandle, 2);
                current_job.job_points       = Sql_GetUIntData(SqlHandle, 3);
                current_job.job_points_spent = Sql_GetUIntData(SqlHandle, 4);

                for (uint8 j = 0; j < JOBPOINTS_JPTYPE_PER_CATEGORY; j++)
                {
                    JobPointType_t current_type = {};
                    current_type.id             = current_job.job_category + j;
                    current_type.value          = Sql_GetUIntData(SqlHandle, JOBPOINTS_SQL_COLUMN_OFFSET + j);
                    memcpy(&current_job.job_point_types[j], &current_type, sizeof(JobPointType_t));
                }

                memcpy(&job_points[jobid], &current_job, sizeof(JobPoints_t));
            }
        }
    }
}

bool CJobPoints::IsJobPointExist(JOBPOINT_TYPE jp_type)
{
    if ((int16)jp_type < JOBPOINTS_CATEGORY_START)
    {
        return false;
    }

    if ((JobPointsCategoryIndexByJpType(jp_type) - 1) > JOBPOINTS_CATEGORY_COUNT)
    {
        return false;
    }

    if (JobPointTypeIndex(jp_type) > JOBPOINTS_JPTYPE_PER_CATEGORY)
    {
        return false;
    }

    return true;
}

JobPoints_t* CJobPoints::GetJobPointsByType(JOBPOINT_TYPE jp_type)
{
    if (IsJobPointExist(jp_type))
    {
        return &job_points[JobPointsCategoryIndexByJpType(jp_type)];
    }

    return nullptr;
}

JobPointType_t* CJobPoints::GetJobPointType(JOBPOINT_TYPE jp_type)
{
    if (IsJobPointExist(jp_type))
    {
        return &job_points[JobPointsCategoryIndexByJpType(jp_type)].job_point_types[JobPointTypeIndex(jp_type)];
    }

    return nullptr;
}

void CJobPoints::RaiseJobPoint(JOBPOINT_TYPE jp_type)
{
    JobPoints_t*    job       = GetJobPointsByType(jp_type);
    JobPointType_t* job_point = GetJobPointType(jp_type);

    uint8 cost = JobPointCost(job_point->value);

    if (cost != 0 && job->job_points >= cost)
    {
        job->job_points -= cost;
        job->job_points_spent += cost;
        job_point->value += 1;

        Sql_Query(SqlHandle, "UPDATE char_job_points SET jptype%u='%u', job_points='%u', job_points_spent='%u' WHERE charid='%u' AND jobid='%u'",
                  JobPointTypeIndex(job_point->id), job_point->value, job->job_points, job->job_points_spent, jp_PChar->id, job->jobid);

        jobpointutils::AddGiftMods(jp_PChar);
    }
}

void CJobPoints::SetJobPoints(int16 amount)
{
    int8 job = (int8)jp_PChar->GetMJob();

    // Limit Job Points within bounds
    if (amount > 500)
    {
        amount = 500;
    }
    else if (amount < 0)
    {
        amount = 0;
    }

    Sql_Query(SqlHandle, "INSERT INTO char_job_points SET charid='%u', jobid='%u', job_points='%u' ON DUPLICATE KEY UPDATE job_points='%u'",
                  jp_PChar->id, job, amount, amount);

    LoadJobPoints();
}

uint16 CJobPoints::GetJobPointsSpent()
{
    return job_points[jp_PChar->GetMJob()].job_points_spent;
}

JobPoints_t* CJobPoints::GetAllJobPoints()
{
    return job_points;
}

uint8 CJobPoints::GetJobPointValue(JOBPOINT_TYPE jp_type)
{
    if (IsJobPointExist(jp_type) && jp_PChar->GetMLevel() >= 99 && jp_PChar->GetMJob() == JobPointsCategoryIndexByJpType(jp_type))
    {
        return GetJobPointType(jp_type)->value;
    }

    return 0;
}

namespace jobpointutils
{
    std::vector<JobPointGifts_t> jp_gifts[MAX_JOBTYPE] = {};

    void LoadGifts()
    {
        if (Sql_Query(SqlHandle, "SELECT jobid, jp_needed, modid, value FROM job_point_gifts ORDER BY jp_needed ASC") != SQL_ERROR)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                JobPointGifts_t gift = {};

                uint8 jobid    = Sql_GetUIntData(SqlHandle, 0);
                gift.jp_needed = Sql_GetUIntData(SqlHandle, 1);
                gift.modid     = Sql_GetUIntData(SqlHandle, 2);
                gift.value     = Sql_GetUIntData(SqlHandle, 3);

                jp_gifts[jobid].push_back(gift);
            }
        }
    }

    void AddGiftMods(CCharEntity* PChar)
    {
        uint16 current_jp = PChar->PJobPoints->GetJobPointsSpent();
        uint8  jobid      = static_cast<uint8>(PChar->GetMJob());

        auto* current_gifts = &PChar->PJobPoints->current_gifts;
        if (current_gifts->empty() != true)
        {
            PChar->delModifiers(current_gifts);
            ShowDebug("Clearing current gifts");
            current_gifts->clear();
        }

        for (auto&& gift : jp_gifts[jobid])
        {
            if (gift.jp_needed > current_jp || PChar->GetMLevel() < 99)
                break;

            current_gifts->push_back(CModifier(static_cast<Mod>(gift.modid), gift.value));
            ShowDebug("Current JP: %d, Gift: %d %d %d\n", current_jp, gift.jp_needed, gift.modid, gift.value);
        }

        PChar->addModifiers(current_gifts);
    }
} // namespace jobpointutils
