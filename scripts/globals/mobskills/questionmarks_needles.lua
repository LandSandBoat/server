-----------------------------------
-- ??? Needles
--
-- Description: Shoots multiple needles at enemies within range.
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- from http://ffxiclopedia.wikia.com/wiki/%3F%3F%3F_Needles
    -- "Seen totals ranging from 15, 000 to 55, 000 needles."
    local needles = math.random(15000, 55000) / skill:getTotalTargets()

    local dmg = xi.mobskills.mobFinalAdjustments(needles, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskillObject
