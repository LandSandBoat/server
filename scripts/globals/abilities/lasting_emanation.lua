-----------------------------------
-- Ability: Lasting Emanation
-- Reduces the amount of HP your luopan consumes.
-- Obtained: Geomancer Level 25
-- Recast Time: 00:05:00
-- Duration: N/A
-- Notes: Base HP drain rate is 24 HP/tic. With Lasting Emenation it is 17HP/tic.
-- Operates on a shared recast timer with Ecliptic Attrition.
-----------------------------------
require("scripts/globals/job_utils/geomancer")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.geomancer.lastingEmanation(player, target, ability)
end

return abilityObject
