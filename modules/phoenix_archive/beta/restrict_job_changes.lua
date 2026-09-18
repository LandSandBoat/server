-----------------------------------
-- Prevents !changejob and !changesjob from being used to switch a player
-- into SCH, DNC, RUN, or GEO.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('restrict_job_changes')

local blockedJobs =
{
    [xi.job.SCH] = true,
    [xi.job.DNC] = true,
    [xi.job.RUN] = true,
    [xi.job.GEO] = true,
}

local function isBlockedJob(jobId)
    if jobId == nil then
        return false
    end

    local resolvedJobId = tonumber(jobId) or xi.job[string.upper(jobId)]

    return blockedJobs[resolvedJobId] == true
end

m:addOverride('xi.commands.changejob.onTrigger', function(player, jobId, level, master)
    if isBlockedJob(jobId) then
        player:printToPlayer('That job is not allowed to be changed to.')
        player:printToPlayer('!changejob <jobID> (level) (master: 0/1)')
        return
    end

    super(player, jobId, level, master)
end)

m:addOverride('xi.commands.changesjob.onTrigger', function(player, jobId, level)
    if isBlockedJob(jobId) then
        player:printToPlayer('That job is not allowed to be changed to.')
        player:printToPlayer('!changesjob <jobID> (level)')
        return
    end

    super(player, jobId, level)
end)
