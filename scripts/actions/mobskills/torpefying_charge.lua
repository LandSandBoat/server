-----------------------------------
--  Torpefying Charge
--
--  Description: Gaze paralysis for 2 minutes.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.PARALYSIS, 15, 0, 120))

    return xi.effect.PARALYSIS
end

return mobskillObject
