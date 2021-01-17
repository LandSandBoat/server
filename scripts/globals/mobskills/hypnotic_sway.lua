---------------------------------------------
-- Hypnotic Sway
-- Description: Inflicts amnesia conal
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local message = tpz.msg.basic.SKILL_MISS
    local typeEffect = tpz.effect.AMNESIA
    local power = 1
    local duration = 60

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskill_object
