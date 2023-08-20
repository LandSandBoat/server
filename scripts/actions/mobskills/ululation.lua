-----------------------------------
-- Ululation
-- Paralyzes all enemies in an area of effect.
--
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, math.random(18, 22), 0, 120))

    return typeEffect
end

return mobskillObject
