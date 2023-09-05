-----------------------------------
--  Acrid Stream
--
--  Description: Deals water damage to enemies within a fan-shaped area originating from the caster. Additional effect: Lowers target's Magic Defense.
--  Type: Magical (Water)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 20
    local duration = 120

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, power, 0, duration)

    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.5, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end

return mobskillObject
