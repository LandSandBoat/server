---------------------------------------------
--  Impulsion
--
--  Description: Deals heavy magical damage to enemies within an area of effect. Additional effects: Petrification, Blind, and Knockback
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes Shadows
--  Note: Used by Bahamut in The Wyrmking Descends
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getID() == 16896156 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1

    local mobhpp = mob:getHPP()
    local baseDmgMult = 2.75
    local basePetrifyDuration = 15
    -- Baha v1 or v2 in gigaflare mode then double the damage and petrify duration
    if
        (mob:getID() == 16896156 and mobhpp <= 10) or
        (mob:getID() == 16896157 and mobhpp <= 50)
    then
        baseDmgMult = 5.5
        basePetrifyDuration = 30
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * baseDmgMult, xi.magic.ele.NONE, dmgmod, xi.mobskills.magicalTpBonus.TP_NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    local typeEffect1 = xi.effect.PETRIFICATION
    local typeEffect2 = xi.effect.BLINDNESS
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect1, 1, 0, basePetrifyDuration)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect2, 15, 0, 60)

    return dmg
end

return mobskillObject
