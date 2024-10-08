-----------------------------------
-- Diving Judgement
-- Description: Deals Light elemental damage to enemies within area of effect.
-- Type: Magical (Light)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 9

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.LIGHT, 3, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return damage
end

return mobskillObject
