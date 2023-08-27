-----------------------------------
-- Chthonian Ray
-- Used only by Mindertaur
-- Description: Frontal AoE Doom. Gaze Attack
-- Type: Gaze
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Conal gaze
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DOOM

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 11, 3, 30))

    return typeEffect
end

return mobskillObject
