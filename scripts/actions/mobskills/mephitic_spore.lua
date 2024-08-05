-----------------------------------
-- Mephitic Spore
-- Deals Dark damage to targets in a fan-shaped area of effect. Additional effect: Poison
-- Type: Breath (But not a breath skill)
-- Utsusemi/Blink absorb: Ignores Shadows
-- Notes: Only used by Fairy Ring
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 50, 3, 180)

    return damage
end

return mobskillObject
