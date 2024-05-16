-----------------------------------
--  Frozen Mist
--  Description: Deals ice damage to enemies around the caster. Additional effect: Terror
--  Type: Magical (Ice)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 30
    local resist   = xi.mobskills.applyPlayerResistance(mob, xi.effect.TERROR, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, 0)
    local duration = 30 * resist

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, power, 0, duration)

    local dmgmod = 1.5
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    return dmg
end

return mobskillObject
