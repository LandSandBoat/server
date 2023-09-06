-----------------------------------
-- func: pettp
-- desc: Sets the players pet tp.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!pettp <amount>')
end

commandObj.onTrigger = function(player, tp)
    -- validate target
    local targ = player:getPet()
    if targ == nil then
        error(player, 'You do not have a pet.')
        return
    end

    -- validate tp amount
    if tp == nil or tp < 0 then
        error(player, 'Invalid amount of tp.')
        return
    end

    -- set pet tp
    targ:setTP(tp)
end

return commandObj
