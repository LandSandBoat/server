-----------------------------------
-- Immortal Anathema
-- Description: Inflicts a curse on all targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: AoE
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CURSE_I

    local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 25, 0, 300)

    skill:setMsg(msg)

    return typeEffect
end

return mobskillObject
