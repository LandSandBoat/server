-----------------------------------
-- Gerjis' Grip
-- Description: Stuns targets in a cone shaped area. Gaze attack.
-- Range : 14'
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.STUN, 1, 0, 10))

    return xi.effect.STUN
end

return mobskillObject
