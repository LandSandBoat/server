-----------------------------------
-- Ability: Afflatus Misery
-- Inspires you to draw strength from the damage you take.
-- Obtained: White Mage Level 40
-- Recast Time: 1:00
-- Duration: 2 hours
-- Restriction: WHM main only
-----------------------------------
require("scripts/globals/job_utils/white_mage")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.white_mage.useAfflatusMisery(player, target, ability)
end

return abilityObject
