-----------------------------------
-- Ability: Diabolic Eye
-- Reduces max. HP, increases accuracy.
-- Obtained: Dark Knight Level 75
-- Recast Time: 0:05:00
-- Duration: 0:03:00
-----------------------------------
require("scripts/globals/job_utils/dark_knight")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useDiabolicEye(player, target, ability)
end

return ability_object
