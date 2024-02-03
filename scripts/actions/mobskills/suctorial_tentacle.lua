-----------------------------------
-- Poison Sting
-- Induces poison
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 5, 3, 180))

    return xi.effect.POISON
end

return mobskillObject
