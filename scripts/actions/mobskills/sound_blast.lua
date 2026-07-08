-----------------------------------
-- Sound Blast
-- 15' Reduces INT of players in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.INT_DOWN, 10, 3, 180))

    return xi.effect.INT_DOWN
end

return mobskillObject
