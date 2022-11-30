-----------------------------------
-- Knife Edge Circle
-- Poisons (20/tick) targets in a conical AoE.
-- Used by Tres Duendes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffectOne = xi.effect.STUN
    local typeEffectTwo = xi.effect.POISON

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1, 0, 1)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 20, 3, 30))

    return typeEffectTwo
end

return mobskillObject
