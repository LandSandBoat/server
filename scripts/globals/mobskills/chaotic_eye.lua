-----------------------------------
-- Chaotic Eye
--
-- Description: Silences an enemy.
-- Type: Magical (Wind)
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
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SILENCE, 1, 0, 60))

    return xi.effect.SILENCE
end

return mobskillObject
