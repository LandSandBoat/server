-----------------------------------
-- Floodlight
-- Description:  ~300 magic damage, Flash, Blind and Silence, ignores Utsusemi
-- Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.LIGHT, 1.5, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 200, 3, 20)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)

    return damage
end

return mobskillObject
