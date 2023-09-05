-----------------------------------
-- Faze
-- Family: Qiqurn
-- Description: Scares a single target.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: Target has to be facing user
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local duration = 5

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end

return mobskillObject
