-----------------------------------
-- Lamentation
--
-- Description: Deals Light damage to all targets in range. Additional effect: Dia
-- Range: 10' cone
-- Wipes Shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DIA, 3, 3, 60)

    return damage
end

return mobskillObject
