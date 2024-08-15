-----------------------------------
--  Molting Burst
--
--  Description: Deals Light damage and drains HP. Transfers any negative status effects to the target.
--  Type: Magical
--  Utsusemi/Blink absorb: Unknown
--  Range: Unknown
--  Notes: Used by Limules affiliated with light element.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 5

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.NUMSHADOWS_2)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return damage
end

return mobskillObject
