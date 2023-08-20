-----------------------------------
-- Ability: Blaze of Glory
-- Increases the effects of your next applicable geomancy spell.
-- Consumes half of that luopan's HP.
-- Obtained: Geomancer Level 60
-- Recast Time: 00:10:00
-- Duration: 00:01:00
-- Notes: Luopan Potency +50%
-- Blaze of Glory has to be active first before using any Geocolure spell.
-----------------------------------
require("scripts/globals/job_utils/geomancer")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.geomancer.blazeOfGlory(player, target, ability)
end

return abilityObject
