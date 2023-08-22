-----------------------------------
-- Poison Sting
-- Induces poison
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 5, 3, 90))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 90)

    return xi.effect.POISON, xi.effect.BIND
end

return mobskillObject
