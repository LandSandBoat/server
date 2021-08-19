-----------------------------------
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = 10
    local duration = 180
    local typeEffect = xi.effect.SHOCK_SPIKES

    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskill_object
