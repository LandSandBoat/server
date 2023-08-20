-----------------------------------
-- Sound Blast
-- 15' Reduces INT of players in area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.INT_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 3, 120))

    return typeEffect
end

return mobskillObject
