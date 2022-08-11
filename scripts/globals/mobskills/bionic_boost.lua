-----------------------------------
-- Bionic Boost
-- Description:
-- Gives the user the effect of counterstance
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
    local typeEffect = xi.effect.COUNTERSTANCE

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 30))
    return typeEffect
end

return mobskill_object
