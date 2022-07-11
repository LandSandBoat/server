---------------------------------------------
-- Riceball
-- Dummy ability used for Tenzen using riceball.
---------------------------------------------
require("scripts/globals/msg")
require("scripts/globals/mobskills")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
