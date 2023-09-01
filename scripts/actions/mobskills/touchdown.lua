-----------------------------------
--  Touchdown
--  Description: Deals magical damage to enemies in an area of effect upon landing.
--  Further Notes:
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.element.NONE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    mob:delStatusEffect(xi.effect.ALL_MISS)
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(2)
    return dmg
end

return mobskillObject
