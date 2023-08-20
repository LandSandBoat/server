-----------------------------------
-- Blank Gaze
-- Powerful Paralyze Gaze Attack.
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 35, 0, 60))

    return typeEffect
end

return mobskillObject
