-----------------------------------
-- Ability: Consume Mana
-- Description: Converts all MP into damage for the next attack.
-- Obtained: Dark Knight Level 55
-- Recast Time: 00:01:00 (or next attack)
-- Duration: 00:01:00
-----------------------------------
require("scripts/globals/job_utils/dark_knight")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useConsumeMana(player, target, ability)
end

return abilityObject
