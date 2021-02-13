-----------------------------------
-- Blank Gaze
-- Powerful Paralyze Gaze Attack.
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
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
    local typeEffect = tpz.effect.PARALYSIS

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 35, 0, 60))

    return typeEffect
end

return mobskill_object
