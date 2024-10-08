-----------------------------------
-- Dust Cloud
-- Deals Earth damage to targets in a fan-shaped area of effect. Additional effect: Blind
-- Range: 10' cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.EARTH, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 120)

    return damage
end

return mobskillObject
