-----------------------------------
-- func: resetlights
-- desc: resets all lights to 0
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!resetlights (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    xi.abyssea.resetPlayerLights(targ)
    player:printToPlayer(string.format('%s\'s lights have been reset!. ', targ:getName()))
end

return commandObj
