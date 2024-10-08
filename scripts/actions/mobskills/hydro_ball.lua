-----------------------------------
--  Hydroball
--  Deals Water damage to targets in a fan-shaped area of effect. Additional effect: STR Down
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Notes: STR reduced by 15%.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3.5

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 3, 120)

    return damage
end

return mobskillObject
