-----------------------------------
-- Ability: No Foot Rise
-- Instantly grants additional Finishing Moves.
-- Obtained: Dancer Level 75 Merit Group 2
-- Recast Time: 3 minutes
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dancer.checkNoFootRiseAbility(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.dancer.useNoFootRiseAbility(player, target, ability)
end

return abilityObject
