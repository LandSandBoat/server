-----------------------------------
-- Discoid
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local needles = 10000 / skill:getTotalTargets()
    local dmg = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskillObject
