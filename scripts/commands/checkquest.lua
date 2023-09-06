-----------------------------------
-- func: !checkquest <logID> <questID> (player)
-- desc: Prints status of the quest to the in game chatlog
-----------------------------------
local logIdHelpers = require('scripts/globals/log_ids')
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'sss'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!checkquest <logID> <questID> (player)')
end

local questStatusString =
{
    [0] = 'AVAILABLE',
    [1] = 'ACCEPTED',
    [2] = 'COMPLETED',
}

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
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- get quest status
    local status = targ:getQuestStatus(logId, questId)

    -- show quest status
    player:PrintToPlayer(string.format('%s\'s status for %s quest ID %i is: %s', targ:getName(), logName, questId, questStatusString[status]))
end

return commandObj
