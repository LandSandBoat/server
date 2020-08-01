---------------------------------------------
--  Dynamic Implosion
--
--  Description: Deals Water damage to enemies in a fan-shaped area of effect. Additional effect: STR Down
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes:
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local power = 50
    local duration = 120

    MobStatusEffectMove(mob, target, tpz.effect.STR_DOWN, power, 3, duration)

    local dmgmod = MobBreathMove(mob, target, 0.1, 1, tpz.magic.ele.FIRE, 200)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.FIRE)
    return dmg

end
