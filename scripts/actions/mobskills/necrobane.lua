-----------------------------------
-- Necrobane
-- Family: Dvergr
-- Description: Curses targets in range of mob. Also inflicts paralysis to all targets facing mob.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- TODO: Handle message priority/fallback
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 50, 0, 60)) -- TODO: Capture duration
    xi.mobskills.mobGazeMove(mob, target, xi.effect.PARALYSIS, 25, 0, 60) -- JPwiki states this is a gaze move. TODO: Capture power/duration.
end

return mobskillObject
