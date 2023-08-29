-----------------------------------
-- Mucus Spread
-- AOE Slow
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SLOW

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 2500, 0, math.random(30, 90)))

    return typeEffect
end

return mobskillObject
