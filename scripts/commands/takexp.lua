-----------------------------------
-- func: takexp <amount> <player>
-- desc: Removes experience points from the target player.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'is'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!takexp <amount> (player)')
end

commandObj.onTrigger = function(player, amount, target)
    -- validate amount
    if amount == nil or amount < 1 then
        error(player, 'Invalid amount.')
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

    -- take xp
    targ:delExp(amount)
    player:printToPlayer(string.format('Removed %i exp from %s. They are now level %i.', amount, targ:getName(), targ:getMainLvl()))
end

return commandObj
