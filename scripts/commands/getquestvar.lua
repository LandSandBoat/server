-----------------------------------
-- Func: getquestvar
-- Desc: Gets a quest variable on the target player.
-----------------------------------
require("scripts/globals/interaction/quest")
-----------------------------------

cmdprops =
{
    permission = 1,
    parameters = "siis"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getquestvar <player> <logId> <questId> <variable>")
end

function onTrigger(player, target, logId, questId, variable, value)
    local targ
    if target == nil then
        error(player, "You must provide a player name.")
        return
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    if logId == nil then
        error(player, "You must provide a Log ID.")
        return
    end

    if questId == nil then
        error(player, "You must provide a Quest ID.")
        return
    end

    if variable == nil then
        error(player, "You must provide a variable name (Ex: Prog, Stage, Option).")
        return
    end

    local questVarName = Quest.getVarPrefix(logId, questId) .. variable
    player:PrintToPlayer(string.format("%s's Quest variable '%s' : %u", targ:getName(), questVarName, targ:getCharVar(questVarName)))
end
