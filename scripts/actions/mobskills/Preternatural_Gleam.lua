-----------------------------------
--  Preternatural Gleam
--  Description: Deals Light damage to enemies in a fan-shaped area originating from caster.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  TODO: Capture range and animation from Cath Palug
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.LIGHT, 1.5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MUTE, 1, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 70, 0, 60)

    return damage
end

return mobskillObject
