-----------------------------------
-- Venom Storm
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.random(20, 30), 3, 60))

    return xi.effect.POISON
end

return mobskillObject
