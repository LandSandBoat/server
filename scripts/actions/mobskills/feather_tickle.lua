-----------------------------------
-- Feather Tickle
-- Description: Reduces tp to zero.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local tpReduced = 0
    target:setTP(tpReduced)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end

return mobskillObject
