-----------------------------------
-- self_destruct_321
-- Weapon skill for Time Bomb (BCNM 50 3, 2, 1...)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local amount = 9999 * skill:getTotalTargets()
    local dmg = xi.mobskills.mobFinalAdjustments(amount, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
