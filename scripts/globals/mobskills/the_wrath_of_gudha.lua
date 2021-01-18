require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local typeEffect = tpz.effect.WEIGHT

    local numhits = 1
    local accmod = 1
    local dmgmod = 5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.NONE, info.hitslanded)

        MobStatusEffectMove(mob, target, typeEffect, 80, 0, 10)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.NONE)
    return dmg
end

return mobskill_object
