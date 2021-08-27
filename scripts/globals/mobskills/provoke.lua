-----------------------------------
-- Provoke
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    target:addEnmity(mob, 1, 1800)
    skill:setMsg(xi.msg.basic.NONE)
end

return mobskill_object
