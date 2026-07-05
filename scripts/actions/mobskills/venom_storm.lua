-----------------------------------
-- Venom Storm
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.randomInt(20, 30), 3, 60))

    return xi.effect.POISON
end

return mobskillObject
