-----------------------------------
--  Dark Wave
--
--  Description: A wave of dark energy washes over targets in an area of effect. Additional effect: Bio
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' radial
--  Notes: Severity of Bio effect varies by time of day, from 8/tic at midday to 20/tic at midnight.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BIO

    local cTime = VanadielHour()
    local power = 8
    if 12 <= cTime then
        power = power + (cTime - 11)
    end

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 3, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskillObject
