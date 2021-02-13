-----------------------------------
-- Slumber Powder
-- 10' Conal sleep
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 30))

    return typeEffect
end

return mobskill_object
