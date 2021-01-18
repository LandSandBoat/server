---------------------------------------------
-- Royal Savior
-- Grants effect of Protect
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = 175
    local duration = 300

    local typeEffect = tpz.effect.PROTECT

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskill_object
