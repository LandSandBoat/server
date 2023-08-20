-----------------------------------
-- Ability: Perfect Dodge
-- Allows you to dodge all melee attacks.
-- Obtained: Thief Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.thief.checkPerfectDodge(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.thief.usePerfectDodge(player, target, ability)
end

return abilityObject
