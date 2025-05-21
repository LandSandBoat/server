-----------------------------------
--  Touchdown
--  Description: Deals magical damage to enemies in an area of effect upon landing.
--  Further Notes:
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.NONE, 1.5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.NONE)

    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(2)

    return damage
end

return mobskillObject
