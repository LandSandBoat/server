-----------------------------------
-- Healing Stomp
--
-- Description: Stomps the ground to apply regeneration.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: Only used by notorious monsters.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 25
    local duration = 180

    local typeEffect = xi.effect.REGEN

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 3, duration))
    return typeEffect
end

return mobskillObject
