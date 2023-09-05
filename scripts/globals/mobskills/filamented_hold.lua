-----------------------------------
-- Filamented Hold
-- Reduces the attack speed of enemies within a fan-shaped area originating from the caster.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 180))

    return xi.effect.SLOW
end

return mobskillObject
