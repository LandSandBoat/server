-----------------------------------
-- Reactive Shield
--
-- Description: Covers the user in shock spikes. Enemies that hit it take lightning damage.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes:
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local power = math.random(20, 30)
    -- local duration = 180
    local typeEffect = xi.effect.SHOCK_SPIKES
    skill:setMsg(MobBuffMove(mob, typeEffect, power, 0, 180))
    return typeEffect
end

return mobskill_object
