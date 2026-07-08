-----------------------------------
-- Wild Card (Mob Skill)
-- Description : Has a random effect on all targets within range.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local tp = 3000
    skill:setMsg(xi.msg.basic.TP_INCREASE)
    target:setTP(tp)

    return tp
end

return mobskillObject
