-----------------------------------
-- func: addabytime
-- desc: Adds an amount of time to the given target. If no target then to the current player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!addabytime <minutes> (player)')
end

commandObj.onTrigger = function(player, minutes, target)
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

    -- target must be in dynamis
    local effect = targ:getStatusEffect(xi.effect.VISITANT)
    if not effect then
        error(player, string.format('%s is not in Abyssea.', targ:getName()))
        return
    end

    -- validate amount
    if minutes == nil or minutes < 1 then
        error(player, 'Invalid number of minutes.')
        return
    end

    -- add time
    local oldDuration = tonumber(effect:getDuration())
    local newDuration = (oldDuration + (tonumber(minutes) * 60)) * 1000

    effect:setDuration(newDuration)
    effect:resetStartTime()
    effect:setIcon(xi.effect.VISITANT)
end

return commandObj
