-----------------------------------
-- func: cp
-- desc: Adds the given amount cp to the player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!cp <amount>')
end

commandObj.onTrigger = function(player, cp)
    -- validate amount
    if cp == nil or cp == 0 then
        error(player, 'Invalid amount.')
        return
    end

    -- add cp
    player:addCP(cp)
    player:PrintToPlayer(string.format('Added %i cp to %s.', cp, player:getName()))
end

return commandObj
