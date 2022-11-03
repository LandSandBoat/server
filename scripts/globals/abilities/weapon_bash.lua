-----------------------------------
-- Ability: Weapon Bash
-- Delivers an attack that can stun the target. Requires Two-handed weapon.
-- Obtained: Dark Knight Level 20
-- Cast Time: Instant
-- Recast Time: 3:00 minutes
-----------------------------------
require("scripts/globals/job_utils/dark_knight")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dark_knight.checkWeaponBash(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.dark_knight.useWeaponBash(player, target, ability)
end

return abilityObject
