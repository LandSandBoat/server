-----------------------------------
-- Sandspray
-- Family: Qiqurn
-- Description: Blinds enemies within a fan-shaped area originating from the user.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
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
    local typeEffect = tpz.effect.BLINDNESS
    local power = 25
    local duration = 90

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskill_object
