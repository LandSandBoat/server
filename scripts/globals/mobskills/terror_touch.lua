---------------------------------------------------
-- Terror Touch
-- Additional effect: Weakens attacks. Accuracy varies with TP.
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_ACC_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)

    local typeEffect = tpz.effect.ATTACK_DOWN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 75, 0, 30)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    return dmg
end

return mobskill_object
