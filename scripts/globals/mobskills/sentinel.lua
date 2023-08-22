-----------------------------------
-- Sentinel
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:addEnmity(mob, 1, 1800)
    skill:setMsg(xi.msg.basic.NONE)
end

return mobskillObject
