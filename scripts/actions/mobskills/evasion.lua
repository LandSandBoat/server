-----------------------------------
-- Evasion
--
-- Description: Increases evasion
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 25% Evasion Boost.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = xi.effect.EVASION_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskillObject
