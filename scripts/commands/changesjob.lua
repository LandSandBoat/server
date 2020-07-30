---------------------------------------------------------------------------------------------------
-- func: changesjob
-- desc: Changes the players current subjob.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!changesjob <jobID> {level}")
end

function onTrigger(player, jobId, level)
    -- validate jobId
    if (jobId == nil) then
        error(player, "You must enter a job short-name, e.g. WAR, or its equivalent numeric ID.")
        return
    end
    jobId = tonumber(jobId) or tpz.job[string.upper(jobId)]
    if (jobId == nil or jobId <= 0 or jobId >= tpz.MAX_JOB_TYPE) then
        error(player, "Invalid jobID.  Use job short name, e.g. WAR, or its equivalent numeric ID.")
        return
    end

    -- validate level
    if (level ~= nil) then
        if (level < 1 or level > 99) then
            error(player, "Invalid level. Level must be between 1 and 99!")
            return
        end
    end

    -- change job and (optionally) level
    player:changesJob(jobId)
    if (level ~= nil) then
        player:setsLevel(level)
    end

    -- invert tpz.job table
    local jobNameByNum={}
    for k, v in pairs(tpz.job) do
        jobNameByNum[v]=k
    end

    -- output new job to player
    player:PrintToPlayer(string.format("You are now a %s%i/%s%i.", jobNameByNum[player:getMainJob()], player:getMainLvl(), jobNameByNum[player:getSubJob()], player:getSubLvl()))
end
