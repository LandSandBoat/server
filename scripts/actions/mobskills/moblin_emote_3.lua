-----------------------------------
-- Moblin Emote (Dance)
-- Description: Has the moblin dance in joy.
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
