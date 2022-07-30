-----------------------------------
-- Chthonian Ray
-- Used only by Mindertaur
-- Description: Frontal AoE Doom. Gaze Attack
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Conal gaze
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
    local typeEffect = xi.effect.DOOM

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 10, 3, 30))

    return typeEffect
end

return mobskill_object
