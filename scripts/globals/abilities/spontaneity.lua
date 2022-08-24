-----------------------------------
-- Ability: Spontaneity
-- Reduces casting time for the next magic spell the target casts.
-- Obtained: Red Mage Level 95
-- Recast Time: 10:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/job_utils/red_mage")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.red_mage.useSpontaneity(player, target, ability)
end

return ability_object
