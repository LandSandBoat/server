-----------------------------------
-- func: mission <logid> <missionid> optional <player-name>, logid and mission ids work by numbers or string.format
-- desc: mission command built with menu control, can add/delete/complete missions, see status,
-- see vars in the IF format of 'Prog', 'Option', 'Stage', 'Wait', 'Timer', etc.
-- Can clear vars in the IF format
-----------------------------------
local logIdHelpers = require('scripts/globals/log_ids')
-----------------------------------

---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sss'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!quest <logId> <missionId> {player}', xi.msg.channel.NS_LINKSHELL3)
end

commandObj.onTrigger = function(player, logId, missionId, target)
    -- validate logId
    local missionLog = logIdHelpers.getMissionLogInfo(logId)
    if missionLog == nil then
        error(player, 'Invalid logID.')
        return
    end

    local logName = missionLog.full_name
    logId = missionLog.mission_log

    -- validate missionId
    local areaMissionIds = xi.mission.id[xi.mission.area[logId]]
    if missionId ~= nil then
        missionId = tonumber(missionId) or areaMissionIds[string.upper(missionId)] or _G[string.upper(missionId)]
    end

    if missionId == nil or missionId < 0 then
        error(player, 'Invalid missionID.')
        return
    end

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
            error(player, string.format('Player named %s not found!', target, xi.msg.channel.NS_LINKSHELL3))
            return
        end
    end

    local currentMission = targ:getCurrentMission(logId)
    local completed      = targ:hasCompletedMission(logId, missionId)
    local missionStatus  = targ:getMissionStatus(logId)

    local menu =
    {
        title = 'Quest Menu',
        onStart = function(playerArg)
            if completed then
                playerArg:printToPlayer(string.format('Player %s has completed requested mission %s, %i', targ:getName(), logName, missionId), xi.msg.channel.NS_LINKSHELL3)
            elseif currentMission == 65535 then
                playerArg:printToPlayer(string.format('Player %s has no MissionID set for %s', targ:getName(), logName), xi.msg.channel.NS_LINKSHELL3)
                return
            end

            playerArg:printToPlayer(string.format('Player %s current missionID is %i for log %s with status of %i', targ:getName(), missionId, logName, missionStatus), xi.msg.channel.NS_LINKSHELL3)
            playerArg:printToPlayer(string.format('Player %s variables for %s mission is %i:', targ:getName(), logName, missionId), xi.msg.channel.NS_LINKSHELL3)

            local vars = targ:getCharVarsWithPrefix(xi.mission.getVarPrefix(logId, missionId))

            local count = 0
            for k, v in pairs(vars) do
                playerArg:printToPlayer(string.format('%s = %s', k, v), xi.msg.channel.NS_LINKSHELL3)
                count = count + 1
            end

            if count == 0 then
                playerArg:printToPlayer('No variables found.', xi.msg.channel.NS_LINKSHELL3)
            end
        end,

        options =
        {
            {
                'Add Mission',
                function(playerArg)
                    targ:addMission(logId, missionId)
                    playerArg:printToPlayer(string.format('Added %s mission %i to %s.', logName, missionId, targ:getName()), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
            {
                'Complete Mission',
                function(playerArg)
                    targ:completeMission(logId, missionId)
                    playerArg:printToPlayer(string.format('Completed %s mission with ID %u for %s', logName, missionId, targ:getName()), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
            {
                'Delete Mission',
                function(playerArg)
                    targ:delMission(logId, missionId)
                    playerArg:printToPlayer(string.format('Deleted %s mission %i from %s.', logName, missionId, targ:getName()), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
            {
                'Clear Vars',
                function(playerArg)
                    targ:clearVarsWithPrefix(xi.mission.getVarPrefix(logId, missionId))
                    playerArg:printToPlayer(string.format('Player %s variables for %s mission %i are cleared', targ:getName(), logName, missionId), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
        },

        onCancelled = function(playerArg)
            playerArg:printToPlayer('Menu Cancelled', xi.msg.channel.NS_LINKSHELL3)
        end,

        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end

return commandObj
