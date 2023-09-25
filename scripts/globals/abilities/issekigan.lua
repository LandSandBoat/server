-----------------------------------
-- Ability: Issekigan
-- Increases Chance of parrying and gives an enmity bonus upon a successful parry attempt.
-- Obtained: Ninja Level 95
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    target:addStatusEffect(xi.effect.ISSEKIGAN, 25, 0, 60)
end

return abilityObject
