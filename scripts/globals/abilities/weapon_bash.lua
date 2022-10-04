-----------------------------------
-- Ability: Weapon Bash
-- Delivers an attack that can stun the target. Requires Two-handed weapon.
-- Obtained: Dark Knight Level 20
-- Cast Time: Instant
-- Recast Time: 3:00 minutes
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dark_knight.checkWeaponBash(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.dark_knight.useWeaponBash(player, target, ability)
end

return ability_object
