-----------------------------------
-- func: setgil
-- desc: Sets the players gil.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!setgil <amount>')
end

commandObj.onTrigger = function(player, amount)
    -- validate amount
    if amount == nil or amount < 0 then
        error(player, 'Invalid amount.')
        return
    end

    player:setGil(amount)
    player:PrintToPlayer(string.format('%s\'s gil was set to %i.', player:getName(), amount))
end

return commandObj
