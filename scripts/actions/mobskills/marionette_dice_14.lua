-----------------------------------
--  Marionette Dice (Job Ability or Spell)
--  Description: Rolls the dice and orders the target to use a 2-hour ability based on its' job.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.USES)

    return 0
end

return mobskillObject
