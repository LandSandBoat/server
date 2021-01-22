-----------------------------------
-- Spoil
--
-- Description: Lowers the strength of target.
-- Type: Enhancing
-- Utsusemi/Blink absorb: Ignore
-- Range: Self
-- Notes: Very sharp evasion increase.
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
    local typeEffect = tpz.effect.STR_DOWN
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 10, 3, 120))

    return typeEffect
end

return mobskill_object
