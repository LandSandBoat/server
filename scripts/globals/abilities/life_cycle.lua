-----------------------------------
-- Ability: Life Cycle
-- Distributes one fourth of your HP to your luopan.
-- Obtained: Geomancer Level 50
-- Recast Time: 10 minutes
-- Grants your luopan 25% of your current HP.
-- The HP lost is not affected by gear or job points.
-- You also subsequently cannot kill yourself using this JA.
-- The increase in Life Cycle potency from Job points is applied in the same set as equipment bonuses.
-----------------------------------
require("scripts/globals/job_utils/geomancer")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnLifeCycleAbilityCheck(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.geomancer.lifeCycle(player, target, ability)
end

return ability_object
