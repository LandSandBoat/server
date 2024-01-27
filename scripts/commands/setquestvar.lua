-----------------------------------
-- Func: setquestvar
-- Desc: Sets a quest variable on the target player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'siisi'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!setquestvar <player> <logId> <questId> <variable> <value>')
end

commandObj.onTrigger = function(player, target, logId, questId, variable, value)
    local targ
    if target == nil then
        error(player, 'You must provide a player name.')
        return
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    if logId == nil then
        error(player, 'You must provide a Log ID.')
        return
    end

    if questId == nil then
        error(player, 'You must provide a Quest ID.')
        return
    end

    if variable == nil then
        error(player, 'You must provide a variable name (Ex: Prog, Stage, Option).')
        return
    end

    if value == nil then
        error(player, 'You must provide a value.')
        return
    end

    local questVarName = Quest.getVarPrefix(logId, questId) .. variable
    targ:setCharVar(questVarName, value)
    player:printToPlayer(string.format('Set %s\'s Quest variable \'%s\' to %i.', targ:getName(), questVarName, value))
end

return commandObj
