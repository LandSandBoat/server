-----------------------------------
-- Gravity Field
-- Entangles all targets in an area of effect.
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
    local typeEffect = xi.effect.SLOW
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1250, 0, 120))

    return typeEffect
end

return mobskill_object
