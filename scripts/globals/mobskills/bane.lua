-----------------------------------
-- Bane
-- Description: Inflicts a curse on all targets in an area of effect.
-- Type: Enfeebling
-- Range: 12' radial
-- Notes: Curse has a very long duration.
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
    local typeEffect = xi.effect.BANE

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 25, 0, 480))

    return typeEffect
end

return mobskill_object
