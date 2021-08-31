-----------------------------------
-- Discoid
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local needles = 10000 / skill:getTotalTargets()
    local dmg = MobFinalAdjustments(needles, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskill_object
