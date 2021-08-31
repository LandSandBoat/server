-----------------------------------
-- self_destruct_321
-- Weapon skill for Time Bomb (BCNM 50 3, 2, 1...)
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local amount = 9999 * skill:getTotalTargets()
    local dmg = MobFinalAdjustments(amount, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
