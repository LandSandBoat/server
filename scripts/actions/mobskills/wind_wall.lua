-----------------------------------
-- Wind Wall
--
-- Description: Invokes a protective wind barrier for increased evasion.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Very sharp evasion increase.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 50, 0, 60))

    return xi.effect.EVASION_BOOST
end

return mobskillObject
