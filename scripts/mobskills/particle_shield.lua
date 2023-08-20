-----------------------------------
-- Particle Shield
--
-- Description: Enhances defense.
-- Type: Magical
-- Notes: Ultima only.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 100, 0, 300))
    return typeEffect
end

return mobskillObject
