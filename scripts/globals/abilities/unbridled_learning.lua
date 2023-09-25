-----------------------------------
-- Ability: Unbridled Learning
-- Description: Allows access to additional blue magic spells.
-- Obtained: BLU Level 95
-- Recast Time: 00:05:00
-- Duration: 00:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.UNBRIDLED_LEARNING, 16, 1, 60)
end

return abilityObject
