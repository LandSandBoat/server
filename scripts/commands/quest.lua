-----------------------------------
-- func: quest <logid> <questid> optional <player-name>, logid and quest ids work by numbers or string.format
-- desc: quest command built with menu control, can add/delete/complete quests, see status,
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
    player:printToPlayer('!quest <logId> <questId> {player}', xi.msg.channel.NS_LINKSHELL3)
end

commandObj.onTrigger = function(player, logId, questId, target)
    -- validate logId
    local questLog = logIdHelpers.getQuestLogInfo(logId)
    if questLog == nil then
        error(player, 'Invalid logID.')
        return
    end

    local logName = questLog.full_name
    logId = questLog.quest_log

    -- validate questId
    local areaQuestIds = xi.quest.id[xi.quest.area[logId]]
    if questId ~= nil then
        questId = tonumber(questId) or areaQuestIds[string.upper(questId)]
    end

    if questId == nil or questId < 0 then
        error(player, 'Invalid questID.')
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

    local status = targ:getQuestStatus(logId, questId)

    local menu =
    {
        title = 'Quest Menu',
        onStart = function(playerArg)
            local statusName = 'Error'
            switch (status): caseof
            {
                [0] = function(x)
                    statusName = 'AVAILABLE'
                end,

                [1] = function(x)
                    statusName = 'ACCEPTED'
                end,

                [2] = function(x)
                    statusName = 'COMPLETED'
                end,
            }
            playerArg:printToPlayer(string.format('Player %s status for %s quest ID %i is: %s', targ:getName(), logName, questId, statusName), xi.msg.channel.NS_LINKSHELL3)
            playerArg:printToPlayer(string.format('Player %s variables for %s Quest %i are:', targ:getName(), logName, questId), xi.msg.channel.NS_LINKSHELL3)

            local targetQuest = xi.quest.getVarPrefix(logId, questId)
            local questVars   = targ:getCharVarsWithPrefix(targetQuest)
            local count       = 0

            for tag, value in pairs(questVars) do
                playerArg:printToPlayer(string.format('%s = %s', tag, value), xi.msg.channel.NS_LINKSHELL3)
                count = count + 1
            end

            if count == 0 then
                playerArg:printToPlayer('No variables found.', xi.msg.channel.NS_LINKSHELL3)
            end
        end,

        options =
        {
            {
                'Add Quest',
                function(playerArg)
                    if status == xi.questStatus.QUEST_ACCEPTED then
                        playerArg:printToPlayer(string.format('Quest %s %i is already Accepted on %s', logName, questId, targ:getName()), xi.msg.channel.NS_LINKSHELL3)
                        return
                    elseif status == xi.questStatus.QUEST_COMPLETED then
                        targ:delQuest(logId, questId)
                        playerArg:printToPlayer(string.format('Quest was in Completed status'), xi.msg.channel.NS_LINKSHELL3)
                    end

                    targ:addQuest(logId, questId)
                    playerArg:printToPlayer(string.format('Added %s quest %i to %s.', logName, questId, targ:getName()), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
            {
                'Complete Quest',
                function(playerArg)
                    if status == xi.questStatus.QUEST_COMPLETED then
                        playerArg:printToPlayer(string.format('Quest %s %i is already Completed', logName, questId), xi.msg.channel.NS_LINKSHELL3)
                        return
                    elseif status == xi.questStatus.QUEST_AVAILABLE then
                        targ:addQuest(logId, questId)
                        playerArg:printToPlayer(string.format('Quest was in the Available status'), xi.msg.channel.NS_LINKSHELL3)
                    end

                    targ:completeQuest(logId, questId)
                    playerArg:printToPlayer(string.format('Completed %s Quest with ID %u for %s', logName, questId, targ:getName()), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
            {
                'Delete Quest',
                function(playerArg)
                    if status == xi.questStatus.QUEST_AVAILABLE then
                        playerArg:printToPlayer(string.format('Quest %s %i is already in Available status', logName, questId), xi.msg.channel.NS_LINKSHELL3)
                        return
                    end

                    targ:delQuest(logId, questId)
                    playerArg:printToPlayer(string.format('Deleted %s quest %i from %s.', logName, questId, targ:getName()), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
            {
                'Clear Vars',
                function(playerArg)
                    targ:clearVarsWithPrefix(xi.quest.getVarPrefix(logId, questId))
                    playerArg:printToPlayer(string.format('Player %s variables for %s Quest %i are cleared', targ:getName(), logName, questId), xi.msg.channel.NS_LINKSHELL3)
                end,
            },
        },

        onCancelled = function(playerArg)
            playerArg:printToPlayer('Quest Menu Cancelled', xi.msg.channel.NS_LINKSHELL3)
        end,

        onEnd = function(playerArg)
        end,
    }
    player:customMenu(menu)
end

return commandObj
