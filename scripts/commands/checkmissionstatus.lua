-----------------------------------
-- func: checkmissionstatus <Log ID> <Player>
-- desc: Prints current missionStatus for the given LogID and target Player to the in game chatlog
-----------------------------------

require("scripts/globals/missions")

cmdprops =
{
    permission = 1,
    parameters = "ssi"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!checkmissionstatus {player} {log ID} {index}")
end

function onTrigger(player, target, logId, statusIndex)

    if statusIndex ~= nil then
        if statusIndex > 7 or statusIndex < 0 then
            error(player, "Invalid index!")
            return
        end
    end

    -- validate logId
    local logName
    local logInfo = GetMissionLogInfo(logId)
    if logInfo == nil then
        logInfo = GetMissionLogInfo(player:getNation())
    end
    logName = logInfo.full_name
    logId = logInfo.mission_log

    -- validate target
    local targ
    if target == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isPC() then
            targ = player
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- report mission
    local currentMissionStatus = targ:getMissionStatus(logId, statusIndex)
    if statusIndex then
        player:PrintToPlayer( string.format( "missionStatus for %s (%s index %s): %s", targ:getName(), logName, statusIndex, currentMissionStatus) )
    else
        player:PrintToPlayer( string.format( "missionStatus for %s (%s): %s", targ:getName(), logName, currentMissionStatus) )
    end
end
