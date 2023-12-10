-----------------------------------
-- func: changejob
-- desc: Changes the players current job.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sii'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!changejob <jobID> (level) (master: 0/1)')
end

commandObj.onTrigger = function(player, jobId, level, master)
    -- validate jobId
    if jobId == nil then
        error(player, 'You must enter a job short-name, e.g. WAR, or its equivalent numeric ID.')
        return
    end

    jobId = tonumber(jobId) or xi.job[string.upper(jobId)]
    if jobId == nil or jobId <= 0 or jobId >= xi.MAX_JOB_TYPE then
        error(player, 'Invalid jobID.  Use job short name, e.g. WAR, or its equivalent numeric ID.')
        return
    end

    -- validate level
    if level ~= nil then
        if level < 1 or level > 99 then
            error(player, 'Invalid level. Level must be between 1 and 99!')
            return
        end
    end

    -- change job and (optionally) level
    player:changeJob(jobId)
    if level ~= nil then
        player:setLevel(level)
    end

    -- master the job if addition params passed
    local masterJob = false
    if master and master == 1 then
        masterJob = true
        player:masterJob()
    end

    -- invert xi.job table
    local jobNameByNum = {}
    for k, v in pairs(xi.job) do
        jobNameByNum[v] = k
    end

    -- output new job to player
    local masterStr = masterJob and ' (Mastered)' or ''
    player:printToPlayer(string.format('You are now a %s%i/%s%i%s.', jobNameByNum[player:getMainJob()], player:getMainLvl(), jobNameByNum[player:getSubJob()], player:getSubLvl(), masterStr))
end

return commandObj
