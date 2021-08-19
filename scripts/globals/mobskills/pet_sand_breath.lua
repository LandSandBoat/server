-----------------------------------
--  Flame Breath
--
--  Description: Deals Flame breath damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Flame)
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local dmgmod = MobBreathMove(mob, target, 0.3, 0.75, xi.magic.ele.EARTH, 460)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.EARTH)
    return dmg
end

return mobskill_object
