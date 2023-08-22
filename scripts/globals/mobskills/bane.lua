-----------------------------------
-- Bane
-- Description: Inflicts a curse on all targets in an area of effect.
-- Type: Enfeebling
-- Range: 12' radial
-- Notes: Curse has a very long duration.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BANE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 40, 0, 480))

    return typeEffect
end

return mobskillObject
