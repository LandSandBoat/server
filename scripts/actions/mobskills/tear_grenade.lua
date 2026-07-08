-----------------------------------
-- Tear Grenade
-- Family: Orc Warmachine
-- Description: Silences and Blinds target in a cone.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    xi.mobskills.mobGazeMove(mob, target, xi.effect.BLINDNESS, 1, 0, 60)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SILENCE, 1, 0, 60))

    return xi.effect.SILENCE
end

return mobskillObject
