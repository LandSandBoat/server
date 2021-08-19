-----------------------------------
-- Brain Drain
-- Deals damage to a single target. Additional effect: INT Down
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

    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, info.hitslanded)

    local typeEffect = xi.effect.INT_DOWN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 10, 3, 120)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return dmg
end

return mobskill_object
