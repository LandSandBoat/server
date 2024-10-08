-----------------------------------
-- Silencing Microtube
-- Deals Magic damage to target. Additional effect: Silence
-- Used by Adelheid (Trust)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 5

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.NONE, 2.45, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    return damage
end

return mobskillObject
