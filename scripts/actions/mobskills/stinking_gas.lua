-----------------------------------
-- Stinking Gas
-- Description: Lowers Vitality of enemies within range.
-- Type: Magical (Wind)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 10, 3, 120))

    return xi.effect.VIT_DOWN
end

return mobskillObject
