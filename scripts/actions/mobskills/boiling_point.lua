-----------------------------------
-- Boiling Point
--
-- Description: Reduces magic defense in a fan-shaped area of effect.
-- Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 20, 0, 180))

    return xi.effect.MAGIC_DEF_DOWN
end

return mobskillObject
