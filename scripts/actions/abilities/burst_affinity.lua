-----------------------------------
-- Ability: Burst Affinity
-- Makes it possible for your next "magical" blue magic spell to be used in a Magic Burst.
-- Obtained: Blue Mage Level 25
-- Recast Time: 2 minutes
-- Duration: 30 seconds
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkBurstAffinity(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.blue_mage.useBurstAffinity(player, target, ability, action)
end

return abilityObject
