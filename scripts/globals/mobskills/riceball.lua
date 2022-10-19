---------------------------------------------
-- Riceball
-- Dummy ability used for Tenzen using riceball.
---------------------------------------------
require("scripts/globals/msg")
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
