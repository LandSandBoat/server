-----------------------------------
--  Great Sandstorm
--  Description: Deals Wind damage to single target. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Single target
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() * 3, xi.element.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 180)

    return damage
end

return mobskillObject
