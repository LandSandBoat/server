-----------------------------------
-- Mucus Spread
-- AOE Slow
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 2500, 0, 30))

    return xi.effect.SLOW
end

return mobskillObject
