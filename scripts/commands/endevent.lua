-----------------------------------
-- func: endevent <player>
-- desc: Force-end the current cutscene/event for a player (GM only).
--       Useful when the client is stuck during an event.
-----------------------------------

---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!endevent (player)')
end

commandObj.onTrigger = function(player, targetName)
    local targ
    if targetName == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isPC() then
            targ = player
        end
    else
        targ = GetPlayerByName(targetName)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', targetName))
            return
        end
    end

    if not targ:isPC() then
        error(player, 'Target is not a player.')
        return
    end

    if targ:isInEvent() then
        targ:release()
        player:printToPlayer(string.format('Ended event for %s.', targ:getName()))
    else
        player:printToPlayer(string.format('%s is not currently in an event.', targ:getName()))
    end
end

return commandObj

