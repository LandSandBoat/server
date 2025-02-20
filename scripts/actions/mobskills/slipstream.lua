-----------------------------------
-- Slipstream
-- Reduces accuracy of targets in area of effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 25, 0, math.random(120, 180)))

    return xi.effect.ACCURACY_DOWN
end

return mobskillObject
