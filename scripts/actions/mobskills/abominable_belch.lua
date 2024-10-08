-----------------------------------
-- Abominable Belch
-- Description: inflicts all targets in an area of effect with silence, paralysis and plague.
-- Radial
-- Ignores Shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 60)

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 10, 3, xi.mobskills.calculateDuration(skill:getTP(), 15, 45)))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, duration))

    return xi.effect.PLAGUE
end

return mobskillObject
