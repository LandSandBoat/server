-----------------------------------
-- Kibosh
-- Family: Qiqurn
-- Description: Inflicts amnesia on a single target.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
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
    local typeEffect = tpz.effect.AMNESIA
    local power = 1
    local duration = 60

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))

    return typeEffect
end

return mobskill_object
