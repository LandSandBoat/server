-----------------------------------
-- Occultation
--
-- Description: Creates 25 shadows
-- Type: Magical (Wind)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local base = math.random(10, 25)
    local typeEffect = xi.effect.BLINK

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, base, 0, 120))
    return typeEffect
end

return mobskillObject
