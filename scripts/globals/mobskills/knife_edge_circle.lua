-----------------------------------
-- Knife Edge Circle
-- Poisons (20/tick) targets in a conical AoE.
-- Used by Tres Duendes
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 20, 3, math.random(60, 120)))
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.random(5, 15))

    return xi.effect.POISON, xi.effect.STUN
end

return mobskillObject
