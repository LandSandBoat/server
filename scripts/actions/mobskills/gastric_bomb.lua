-----------------------------------
-- Gastric Bomb
-- Deals Water damage with a long-range acid bomb. Additional effect: Attack Down
-- Range: Long range
-- Notes: Attack Down effect is 50%.
-- Duration: Three minutes
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 50, 0, 180)

    return damage
end

return mobskillObject
