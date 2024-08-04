-----------------------------------
-- Ability: Mikage
-- Grants a bonus to number of main weapon attacks that varies with the number of remaining Utsusemi Shadow Images.
-- Obtained: Ninja Level 96
-- Recast Time: 1:00:00
-- Duration: 45 seconds
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.ninja.checkMikage(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.ninja.useMikage(player, target, ability, action)
end

return abilityObject
