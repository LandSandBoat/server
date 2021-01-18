---------------------------------------------------
-- Poison Sting
-- Deals Water damage to targets in a fan-shaped area of effect. Additional effect: Poison
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
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)

    local typeEffect = tpz.effect.POISON
    local power = mob:getMainLvl()/10 + 3
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 3, 60)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end

return mobskill_object
