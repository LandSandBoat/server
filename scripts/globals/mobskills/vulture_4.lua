-----------------------------------
-- (Vulture 4)
-- Dummy ability used for 2hr animation.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
