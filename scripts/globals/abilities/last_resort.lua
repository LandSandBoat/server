-----------------------------------
-- Ability: Last Resort
-- Increases user's attack, but lowers defense.
-- Obtained: Dark Knight Level 15
-- Recast Time: 5:00
-- Duration: 3:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useLastResort(player, target, ability)
end

return ability_object
