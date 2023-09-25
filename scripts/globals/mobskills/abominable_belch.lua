-----------------------------------
-- Abominable Belch
-- Description: inflicts all targets in an area of effect with silence, paralysis and plague.
-- Radial
-- Ignores Shadows
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 1, 3, 120))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 120))

    return xi.effect.PLAGUE
end

return mobskillObject
