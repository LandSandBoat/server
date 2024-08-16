-----------------------------------
-- Vile Belch
-- Description: Belches up noxious fumes, inflicting all targets in an area of effect with Silence and Plague.
-- Radial
-- Ignores Shadows
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 10, 3, xi.mobskills.calculateDuration(skill:getTP(), 15, 45)))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, xi.mobskills.calculateDuration(skill:getTP(), 30, 60)))

    return xi.effect.PLAGUE
end

return mobskillObject
