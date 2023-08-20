-----------------------------------
-- Feather Barrier
--
-- Description: Enhances evasion.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.EVASION_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 20, 0, 120))

    return typeEffect
end

return mobskillObject
