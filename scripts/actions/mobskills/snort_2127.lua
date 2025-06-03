-----------------------------------
-- Snort
-- Description: Deals Wind damage to targets in a fan-shaped area of effect. Additional effect: Knockback
-- Type: Magical (Wind)
-- Note: Shows as a regular attack and lowers enmity
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    mob:lowerEnmity(target, 25)

    return damage
end

return mobskillObject
