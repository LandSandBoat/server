-----------------------------------
-- func: changesjob
-- desc: Changes the players current subjob.
-----------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!changesjob <jobID> (level)")
end

function onTrigger(player, jobId, level)
    -- validate jobId
    if jobId == nil then
        error(player, "You must enter a job short-name, e.g. WAR, or its equivalent numeric ID.")
        return
    end

    jobId = tonumber(jobId) or xi.job[string.upper(jobId)]
    if
        jobId == nil or
        jobId < 0 or
        jobId >= xi.MAX_JOB_TYPE
    then
        error(player, "Invalid jobID.  Use job short name, e.g. WAR, or its equivalent numeric ID.")
        return
    end

    -- validate level
    if level ~= nil then
        -- invalid level
        if
            level < 1 or
            level > 99
        then
            error(player, "Invalid level. Level must be between 1 and 99!")
            return
        end
        -- setting none sjob to a different level
        if jobId == 0 then
            error(player, "Invalid argument. NONE must have no level parameter, e.g. !changesjob NONE.")
            return
        end
    end

    -- invert xi.job table
    local jobNameByNum = {}
    for k, v in pairs(xi.job) do
        jobNameByNum[v] = k
    end

    -- special case: remove sub
    if jobId == 0 then
        -- setting sjob level before sjob change changes the job's actual level
        -- setting sjob level after sjob change calls SQL with an empty query
        -- set the sjob to NONE and change player message to avoid confusion
        player:changesJob(0)
        player:PrintToPlayer(string.format("You are now a %s%i.", jobNameByNum[player:getMainJob()], player:getMainLvl()))
        return
    end

    -- change job and (optionally) level
    player:changesJob(jobId)
    if level ~= nil then
        player:setsLevel(level)
    end

    -- output new job to player
    player:PrintToPlayer(string.format("You are now a %s%i/%s%i.", jobNameByNum[player:getMainJob()], player:getMainLvl(), jobNameByNum[player:getSubJob()], player:getSubLvl()))
end
