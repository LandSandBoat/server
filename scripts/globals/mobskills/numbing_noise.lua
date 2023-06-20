-----------------------------------
-- Numbing Noise
-- Description: Creates an unsettling sound. Additional effect: Stun
-- Type: Physical
-- Utsusemi/Blink absorb: Ignore
-- Range: 10' cone
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STUN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 5))

    return typeEffect
end

return mobskillObject
