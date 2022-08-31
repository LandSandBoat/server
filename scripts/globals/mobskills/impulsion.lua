---------------------------------------------
--  Impulsion
--
--  Description: Deals heavy magical damage to enemies within an area of effect. Additional effects: Petrification, Blind, and Knockback
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes Shadows
--  Note: Used by Bahamut in The Wyrmking Descends
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else
        return 0
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 4

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.TP_NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    local typeEffect1 = xi.effect.PETRIFICATION
    local typeEffect2 = xi.effect.BLINDNESS
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect1, 1, 0, 30)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect2, 15, 0, 60)

    return dmg
end

return mobskill_object
