-----------------------------------
-- Ability: Divine Seal
-- Enhances the potency of the user's next healing spell.
-- Obtained: White Mage Level 15
-- Recast Time: 10:00
-- Duration: 1 Spell or 60 seconds, whichever occurs first.
-----------------------------------
require("scripts/globals/job_utils/white_mage")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.white_mage.useDivineSeal(player, target, ability)
end

return ability_object
