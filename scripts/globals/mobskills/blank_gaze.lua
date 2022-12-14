-----------------------------------
-- Blank Gaze
-- Powerful Paralyze Gaze Attack.
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee?
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
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PARALYSIS, 35, 0, 180))

    return xi.effect.PARALYSIS
end

return mobskillObject
