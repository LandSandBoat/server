-----------------------------------
-- Cold Stare
-- Silences enemies in a line area of effect.
-- Notes: Only applies when face-to-face with the dhalmel.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE
    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 60))
    return typeEffect
end

return mobskill_object
