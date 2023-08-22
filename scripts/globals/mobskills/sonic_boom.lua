-----------------------------------
-- Sonic Boom
-- Reduces attack of targets in area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 25, 0, math.random(120, 180)))

    return xi.effect.ATTACK_DOWN
end

return mobskillObject
