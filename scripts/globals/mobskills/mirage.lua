---------------------------------------------
-- Mirage
--
-- Description: Enhances evasion.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Very sharp evasion increase.
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
    local typeEffect = tpz.effect.EVASION_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, 20, 0, 60))
    return typeEffect
end

return mobskill_object
