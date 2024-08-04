-----------------------------------
-- Ability: Camouflage
-- Become hidden from enemies.
-- Obtained: Ranger Level 20
-- Recast Time: 5:00
-- Duration: Random
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.ranger.checkCamouflage(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.ranger.useCamouflage(player, target, ability, action)
end

return abilityObject
