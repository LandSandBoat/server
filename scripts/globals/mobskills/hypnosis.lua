-----------------------------------
-- Slumber Powder
-- 10' Conal sleep
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
    local typeEffect = xi.effect.SLEEP_I

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, 30))

    return typeEffect
end

return mobskill_object
