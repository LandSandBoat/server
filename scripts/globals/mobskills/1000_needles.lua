-----------------------------------
--  1000 Needles
--
--  Description: Shoots multiple needles at enemies within range.
--  Type: Physical (Piercing)
--
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local needles = 1000 / skill:getTotalTargets()

    local dmg = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return dmg
end

return mobskill_object
