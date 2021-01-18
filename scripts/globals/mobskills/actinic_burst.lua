---------------------------------------------
-- Actinic Burst
-- Family: Ghrah
-- Description: Greatly lowers the accuracy of enemies within range for a brief period of time.
-- Type: Magical (Light)
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-- Notes:
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
    local typeEffect = tpz.effect.FLASH
    local power = 200
    local duration = 20

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskill_object
