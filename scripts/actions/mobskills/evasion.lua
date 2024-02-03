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

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, power, 0, duration))

    return xi.effect.EVASION_BOOST
end

return mobskillObject
