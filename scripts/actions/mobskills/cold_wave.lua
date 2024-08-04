-----------------------------------
--  Cold Wave
--  Description: Deals ice damage that lowers Agility and gradually reduces HP of enemies within range.
--  Type: Magical (Ice)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2.8
    local power  = mob:getMainLvl() / 5 * 0.6 + 6

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.ICE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, power, 3, 60)

    return damage
end

return mobskillObject
