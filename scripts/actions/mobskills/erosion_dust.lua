-----------------------------------
-- Erosion Dust
-- Description: Dealing damage and inflicting Dia.
-- Type: Magical (Light)
-- Range: AoE
-- Utsusemi/Blink absorb: Wipe Shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3.3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    local duration = xi.mobskills.calculateDuration(skill:getTP(), 10, 30)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DIA, 3, 3, duration)

    return damage
end

return mobskillObject
