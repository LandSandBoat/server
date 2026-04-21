-----------------------------------
-- Call of the Wyrmking
-- Description: Roars to the sky, calling forth Ouryu, Tiamat, Jormungand or Vrtra to join the battle.
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
