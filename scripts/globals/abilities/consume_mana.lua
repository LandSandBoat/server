-----------------------------------
-- Ability: Consume Mana
-- Converts all MP into damage for the next attack.
-- Obtained: Dark Knight Level 55
-- Recast Time: 1:00 (or next attack)
-- Duration: 1:00
-----------------------------------
require("scripts/globals/job_utils/dark_knight")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useConsumeMana(player, target, ability)
end

return ability_object
