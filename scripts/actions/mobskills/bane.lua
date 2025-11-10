-- Bane
-- Description: Inflicts an extremely strong curse on all targets in an area of effect
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 15' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BANE, 65, 0, 600))

    return xi.effect.BANE
end

return mobskillObject
