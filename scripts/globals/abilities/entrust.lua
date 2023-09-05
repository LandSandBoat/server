-----------------------------------
-- Ability: Entrust
-- Causes the next indicolure spell cast to be able to target a party member.
-- Obtained: Geomancer Level 75
-- Recast Time: 00:10:00
-- Duration: 00:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.ENTRUST, 1, 0, 60)
end

return abilityObject
