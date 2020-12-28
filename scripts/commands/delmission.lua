---------------------------------------------------------------------------------------------------
-- func: delmission <logID> <missionID> <player>
-- desc: Deletes the given mission from the GM or target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/missions")

cmdprops =
{
    permission = 1,
    parameters = "sss"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!delmission <logID> <missionID> {player}")
end

function onTrigger(player, logId, missionId, target)
    -- validate logId
    local logName
    local logInfo = GetMissionLogInfo(logId)
    if (logInfo == nil) then
        error(player, "Invalid logID.")
        return
    end
    logName = logInfo.full_name
    logId = logInfo.mission_log

    -- validate missionId
    local areaMissionIds = tpz.mission.id[tpz.mission.area[logId]]
    if (missionId ~= nil) then
        missionId = tonumber(missionId) or areaMissionIds[string.upper(missionId)] or _G[string.upper(missionId)]
    end
    if (missionId == nil or missionId < 0) then
        error(player, "Invalid missionID.")
        return
    end

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = tpz.core.getPlayerByName(target)
        if (targ == nil) then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- delete mission
    targ:delMission(logId, missionId)
    player:PrintToPlayer(string.format("Deleted %s mission %i from %s.", logName, missionId, targ:getName()))
end
