-----------------------------------
-- Frame Change
-- Description: Automaton spins around and turns invisible. Used for Ob and & Valkeng
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
