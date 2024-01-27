-----------------------------------
-- func: givexp <amount> <player>
-- desc: Gives the GM or target player experience points.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!givexp <amount> (player)')
end

commandObj.onTrigger = function(player, amount, target)
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

    -- validate amount
    if amount == nil or amount < 1 then
        error(player, 'Invalid amount.')
        return
    end

    -- give XP to target
    targ:addExp(amount)
    player:printToPlayer(string.format('Gave %i exp to %s. They are now level %i.', amount, targ:getName(), targ:getMainLvl()))
end

return commandObj
