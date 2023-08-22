-----------------------------------
--  Typhoon Wing
--
--  Description: Deals darkness damage to enemies within a very wide area of effect. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial.
--  Notes: Used only by Ouryu and Dragua. The blinding effect does not last long
--                but is very harsh. The attack is wide enough to generally hit an entire alliance.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    -- animation sub 1 means flying (0 and 2 means on the ground)
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 60, 0, 30)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 5, 5, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskillObject
