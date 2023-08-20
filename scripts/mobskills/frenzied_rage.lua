-----------------------------------
-- Frenzied Rage
--
-- Description: Attack Boost
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 20% Attack Boost.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 20
    local duration = 120

    local typeEffect = xi.effect.ATTACK_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskillObject
