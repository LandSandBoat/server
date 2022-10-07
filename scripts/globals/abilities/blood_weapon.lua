-----------------------------------
-- Ability: Blood Weapon
-- Causes all attacks to drain enemy's HP.
-- Obtained: Dark Knight Level 1
-- Recast Time: 1:00:00
-- Duration: 0:00:30
-----------------------------------
require("scripts/globals/job_utils/dark_knight")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dark_knight.checkBloodWeapon(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useBloodWeapon(player, target, ability)
end

return abilityObject
