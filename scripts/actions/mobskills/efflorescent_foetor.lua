-----------------------------------
-- Efflorescent Foetor
-- Description: Sprays toxic pollen in a fan-shaped area of effect, inflicting Blind & Silence.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 100, 0, math.random(10, 30)))
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, math.random(10, 30)))

    return xi.effect.BLINDNESS
end

return mobskillObject
