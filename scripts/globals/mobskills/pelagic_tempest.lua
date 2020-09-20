---------------------------------------------
--  Pelagic Tempest
--
--  Description: Delivers an area attack that inflicts Shock and Terror.
--  Type: Physical?
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' cone
--  Notes: Used by Murex affiliated with lightning element. Shock effect is fairly strong (28/tick).
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local numhits = 1
    local accmod = 2
    local dmgmod = 3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)


    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.SHOCK, 28, 3, 180)


    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.TERROR, 1, 0, 180)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)
    return dmg
end
