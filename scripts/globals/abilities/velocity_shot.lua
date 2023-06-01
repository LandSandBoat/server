-----------------------------------
-- Ability: Velocity Shot
-- Increases attack power and speed of ranged attacks, while reducing attack power and speed of melee attacks.
-- Obtained: Ranger Level 45
-- Recast Time: 5:00 minutes
-- Duration: 2 hours
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:addStatusEffect(xi.effect.VELOCITY_SHOT, 1, 0, 7200)
end

return abilityObject
