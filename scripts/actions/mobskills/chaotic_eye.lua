-----------------------------------
-- Chaotic Eye
--
-- Description: Silences an enemy.
-- Type: Magical (Wind)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SILENCE, 1, 0, 120))

    return xi.effect.SILENCE
end

return mobskillObject
