-----------------------------------
-- Pet Charm
-- Actually just Angra Mainyu's teleport but its called "Pet Charm" in the mob skills table.
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
