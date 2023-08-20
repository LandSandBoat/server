-----------------------------------
-- Petribreath
-- Description: Petrifies targets within a fan-shaped area.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown  cone, Seen up to 15' distance.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PETRIFICATION

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))

    return typeEffect
end

return mobskillObject
