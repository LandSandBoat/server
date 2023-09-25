-----------------------------------
-- Ability: Saber Dance
-- Increases Double Attack rate but renders Waltz unusable. Double Attack rate gradually decreases.
-- Obtained: Dancer Level 75 Merit Group 2
-- Recast Time: 3 minutes
-- Duration: 5 minutes
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.SABER_DANCE, 50, 3, 300)
end

return abilityObject
