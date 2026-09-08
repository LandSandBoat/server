-----------------------------------
-- Sonic Boom
-- Used by Nightmare Gylas in Dynamis.
-- Reduces attack of targets in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 50, 0, 90))

    return xi.effect.ATTACK_DOWN
end

return mobskillObject
