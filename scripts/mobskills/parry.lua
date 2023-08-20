-----------------------------------
-- Parry
-- Enhances defense.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 15, 0, 300))
    return typeEffect
end

return mobskillObject
