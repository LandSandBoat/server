-----------------------------------
--  Zarbzan
--
--  Description: Launches a firebomb from its cannon.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown
--  Notes: Used by RNG trolls only as their ranged special attack.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == xi.job.RNG then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg()

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
