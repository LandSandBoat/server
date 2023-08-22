-----------------------------------
--  Hurricane Wing
--
--  Description: Deals hurricane-force wind damage to enemies within a very wide area of effect. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 30' radial.
--  Notes: Used only by Dragua, Fafnir, Nidhogg, Cynoprosopi, Wyrm, and Odzmanouk. The blinding effect does not last long
--                but is very harsh. The attack is wide enough to generally hit an entire alliance.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 96) then
        return 1
    elseif mob:getAnimationSub() == 1 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    local dmgmod = 5

    if mob:getName() == "Nidhogg" then
        dmgmod = 6
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 160, 0, 30)
    else
        xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 100, 0, 30)
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskillObject
