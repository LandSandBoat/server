-----------------------------------
--  Vitriolic Shower
--  Description: Expels a caustic stream at targets in a fan-shaped area of effect. Additional effect: Burn
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadow
--  Range: Cone
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BURN
    local power = math.random(15, 35)


    MobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2.7, xi.magic.ele.FIRE, dmgmod, TP_NO_EFFECT)
    -- NOTE: nil value was undefined MOBPARAM_FIRE
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, MOBSKILL_MAGICAL, nil, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
