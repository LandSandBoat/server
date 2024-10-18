-----------------------------------
--  Tempestuous Upheaval
--
--  Description: Deals Wind damage to enemies within an area of effect. Additional effect: Knockback
--  Type: Magical (Wind)
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 10' radial
--  Notes: The knockback is rather severe.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2.1
    local damage = mob:getWeaponDmg()

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return damage
end

return mobskillObject
