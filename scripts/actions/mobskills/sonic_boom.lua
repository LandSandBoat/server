-----------------------------------
-- Sonic Boom
-- Reduces attack of targets in area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 50, 0, 120))

    return xi.effect.ATTACK_DOWN
end

return mobskillObject
