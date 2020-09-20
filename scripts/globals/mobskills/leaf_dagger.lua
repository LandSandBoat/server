---------------------------------------------
--  Leaf Dagger
--
--  Description: Deals piercing damage to a single target. Additional effect: Poison
--  Type: Physical
--  Utsusemi/Blink absorb: 2 shadows
--  Range: Melee?
--  Notes: On higher level Madragoras (Korrigans for example) the poision is 5hp/tick for about 5-6 ticks, damaging a total of 25-30 HP.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 2
    local accmod = 1
    local dmgmod = 1.4
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING, info.hitslanded)

    local typeEffect = tpz.effect.POISON
    local power = (mob:getMainLvl()/10)
    if (power < 1 ) then
        power = 1
    end

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 3, 18)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.PIERCING)
    return dmg
end
