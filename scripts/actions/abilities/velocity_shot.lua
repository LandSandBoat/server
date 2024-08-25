-----------------------------------
-- Ability: Velocity Shot
-- Increases attack power and speed of ranged attacks, while reducing attack power and speed of melee attacks.
-- Obtained: Ranger Level 45
-- Recast Time: 5:00 minutes
-- Duration: 2 hours
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkVelocityShot(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useVelocityShot(player, target, ability, action)
end

return abilityObject
