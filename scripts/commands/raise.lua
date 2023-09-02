-----------------------------------
-- func: raise <power> <player>
-- desc: Sends raise menu to GM or target player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'ss'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!raise (power) (player)')
end

commandObj.onTrigger = function(player, arg1, arg2)
    local power
    local target
    local targ

    -- decide inputs
    if arg2 ~= nil then
        power = tonumber(arg1)
        target = arg2
    elseif arg1 ~= nil then
        if GetPlayerByName(arg1) == nil then
            power = tonumber(arg1)
        else
            target = arg1
        end
    end

    -- validate power
    if power == nil or power > 3 then
        power = 3
    elseif power < 1 then
        power = 1
    end

    -- validate target
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- raise target
    if targ:isDead() then
        targ:sendRaise(power)
        if targ:getID() ~= player:getID() then
            player:PrintToPlayer(string.format('Raise %i sent to %s.', power, targ:getName()))
        end
    else
        player:PrintToPlayer(string.format('%s is not dead.', targ:getName()))
    end
end

return commandObj
