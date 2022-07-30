---------------------------------------------
-- Fantod
-- Hippogryph Boost Ability.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 60, 0, 180))
    return typeEffect
end

return mobskill_object
