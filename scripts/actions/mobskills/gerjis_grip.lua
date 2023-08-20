-----------------------------------
-- Gerjis' Grip
-- Description: Stun
-- Type: Physical (Blunt)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.STUN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 10))
    return typeEffect
end

return mobskillObject
