-----------------------------------
-- Riddle
--
-- Description: Reduces maximum MP in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 15' radial
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.MAX_MP_DOWN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 42, 0, 120))

    return typeEffect
end

return mobskillObject
