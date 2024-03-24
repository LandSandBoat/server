-----------------------------------
-- Ability: Unbridled Wisdom
-- Description: Allows certain blue magic spells to be cast.
-- Obtained: BLU Level 96
-- Recast Time: 01:00:00
-- Duration: 00:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.UNBRIDLED_WISDOM, 16, 1, 30)
end

return abilityObject
