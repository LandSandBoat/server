-----------------------------------
-- Sound Blast
-- 15' Reduces INT of players in area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 10, 3, 120))

    return xi.effect.INT_DOWN
end

return mobskillObject
