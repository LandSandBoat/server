-----------------------------------
--  Impulsion
--
--  Description: Deals heavy magical damage to enemies within an area of effect. Additional effects: Petrification, Blind, and Knockback
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes Shadows
--  Note: Used by Bahamut in The Wyrmking Descends
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- can only be used by BahamutV2
    if mob:getID() == ID.mob.BAHAMUTV2 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1

    local mobhpp = mob:getHPP()
    local baseDmgMult = 2.75
    local basePetrifyDuration = 15

    -- Bahav2 in gigaflare mode then double the damage and petrify duration
    if mobhpp < 60 then
        baseDmgMult = 5.5
        basePetrifyDuration = 30
    end

    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * baseDmgMult, xi.element.NONE, dmgmod, xi.mobskills.magicalTpBonus.TP_NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, basePetrifyDuration)

    return damage
end

return mobskillObject
