-----------------------------------
-- func: givegil <amount> <player>
-- desc: Gives the specified amount of gil to GM or target player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!givegil <amount> (player)')
end

commandObj.onTrigger = function(player, amount, target)
    -- validate amount
    if amount == nil or amount < 1 then
        error(player, 'Invalid amount of gil.')
        return
    end

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

    -- give gil to target
    targ:addGil(amount)
    player:printToPlayer(string.format('Gave %i gil to %s.  They now have %i gil.', amount, targ:getName(), targ:getGil()))
end

return commandObj
