-----------------------------------
-- func: changesjob
-- desc: Changes the players current subjob.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'si'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!changesjob <jobID> (level)')
end

commandObj.onTrigger = function(player, jobId, level)
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
    player:changesJob(jobId)
    if level ~= nil then
        player:setsLevel(level)
    end

    -- invert xi.job table
    local jobNameByNum = {}
    for k, v in pairs(xi.job) do
        jobNameByNum[v] = k
    end

    -- output new job to player
    player:printToPlayer(string.format('You are now a %s%i/%s%i.', jobNameByNum[player:getMainJob()], player:getMainLvl(), jobNameByNum[player:getSubJob()], player:getSubLvl()))
end

return commandObj
