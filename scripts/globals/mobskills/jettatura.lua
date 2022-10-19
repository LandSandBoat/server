-----------------------------------
-- Jettatura
-- Family: Hippogryph
-- Description: Enemies within a fan-shaped area originating from the caster are frozen with fear.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Cone gaze
-- Notes:
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local duration = 10

    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, typeEffect, 1, 0, duration))

    return typeEffect
end

return mobskillObject
