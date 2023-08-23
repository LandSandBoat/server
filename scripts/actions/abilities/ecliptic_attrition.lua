-----------------------------------
-- Ability: Ecliptic Attrition
-- Enhances the effects of your luopan.
-- Increases the rate at which your luopan consumes its HP.
-- Obtained: Geomancer Level 25
-- Recast Time: 00:05:00
-- Duration: N/A
-- Notes: Luopan Potency +25%
-- Base HP drain rate is 24HP/tic. With Ecliptic attrition it is 30HP/tic.
-- Operates on a shared recast timer with Lasting Emanation
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.geomancer.eclipticAttrition(player, target, ability)
end

return abilityObject
