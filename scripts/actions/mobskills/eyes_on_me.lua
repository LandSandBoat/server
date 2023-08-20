-----------------------------------
--  Eyes on Me
--  Deals dark damage to an enemy.
--  Spell Type: Magical (Dark)
--  Range: Casting range 13'
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = mob:getWeaponDmg() * 4

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.SPECIAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.SPECIAL, xi.damageType.DARK)

    return dmg
end

return mobskillObject
