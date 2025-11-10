-----------------------------------
-- Counterspore
-- Deals Water damage to a single target from up to 15 yalms away. Additional effect: Knockback
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgMod = 3.0

    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.WATER, dmgMod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return damage
end

return mobskillObject
