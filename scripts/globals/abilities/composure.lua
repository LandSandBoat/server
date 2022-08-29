-----------------------------------
-- Ability: Composure
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white and black magic you cast on yourself last longer.
-- Obtained: Red Mage Level 50
-- Recast Time: 5:00
-- Duration: 120 minutes
-----------------------------------
require("scripts/globals/job_utils/red_mage")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.red_mage.useComposure(player, target, ability)
end

return ability_object
