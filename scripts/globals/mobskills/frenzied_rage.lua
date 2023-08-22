-----------------------------------
-- Frenzied Rage
--
-- Description: Attack Boost
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 20% Attack Boost.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 190 / 1024 -- 18.56%
    local duration = 120

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, power, 0, duration))
    return xi.effect.ATTACK_BOOST
end

return mobskillObject
