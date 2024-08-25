-----------------------------------
--  Barofield
--
--  Description: Deals Wind damage to enemies within a fan-shaped area. Additional effect: Weight
--  Type: Magical
--  Ignores Shadows
--  Range: 15' Cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 2, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 25, 0, 60)

    return damage
end

return mobskillObject
