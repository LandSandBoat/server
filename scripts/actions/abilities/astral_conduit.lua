-----------------------------------
-- Ability: Astral Conduit
-- Description: Reduces Blood Pact recast times.
-- Obtained: SMN Level 96
-- Recast Time: 01:00:00
-- Duration: 00:00:30
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.ASTRAL_CONDUIT, 15, 1, 30)
end

return abilityObject
