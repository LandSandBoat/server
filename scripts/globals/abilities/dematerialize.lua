-----------------------------------
-- Ability: Dematerialize
-- Enhances the effects of your luopan.
-- Prevents your luopan from receiving damage.
-- Obtained: Geomancer Level 70
-- Recast Time: 00:10:00
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/job_utils/geomancer")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.geomancer.dematerialize(player, target, ability)
end

return abilityObject
