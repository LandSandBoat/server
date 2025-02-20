-----------------------------------
-- func: reset <player>
-- desc: If no name is specified, resets your own JA timers.
-- If a player name is specified, resets all of that players JA timers.
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
    player:printToPlayer('!reset (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    if not target then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    -- reset target recasts
    targ:resetRecasts()
    if targ:getID() ~= player:getID() then
        player:printToPlayer(string.format('Reset %s\'s recast timers.', targ:getName()))
    end

    -- Clear debilitating effects from player
    player:eraseAllStatusEffect()

    -- Table of non-erasable effects
    local effects =
    {
        xi.effect.TERROR,
        xi.effect.SLEEP_I,
        xi.effect.SLEEP_II,
        xi.effect.LULLABY,
        xi.effect.STUN,
        xi.effect.SILENCE,
        xi.effect.WEAKNESS,
        xi.effect.PARALYSIS,
        xi.effect.BLINDNESS,
        xi.effect.AMNESIA,
        xi.effect.CHARM_I,
        xi.effect.CHARM_II,
        xi.effect.POISON,
        xi.effect.PETRIFICATION,
        xi.effect.DOOM,
        xi.effect.CURSE_I,
        xi.effect.CURSE_II,
    }

    for _, v in pairs(effects) do
        player:delStatusEffect(v)
    end
end

return commandObj
