-----------------------------------
-- Ability: Afflatus Misery
-- Inspires you to draw strength from the damage you take.
-- Obtained: White Mage Level 40
-- Recast Time: 1:00
-- Duration: 2 hours
-- Restriction: WHM main only
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    target:delStatusEffect(xi.effect.AFFLATUS_SOLACE)
    target:delStatusEffect(xi.effect.AFFLATUS_MISERY)
    target:addStatusEffect(xi.effect.AFFLATUS_MISERY, 8, 0, 7200)
end

return ability_object
