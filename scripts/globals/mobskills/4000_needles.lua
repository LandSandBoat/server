-----------------------------------
-- 4000 Needles
-- Description: Shoots multiple needles at enemies within range.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local needles = 4000 / skill:getTotalTargets()
    local dmg     = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskillObject
