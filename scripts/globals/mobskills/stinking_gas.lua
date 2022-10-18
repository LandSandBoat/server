-----------------------------------
-- Stinking Gas
--
-- Description: Lowers Vitality of enemies within range.
-- Type: Magical (Wind)
--
--
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
    local typeEffect = xi.effect.VIT_DOWN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 10, 3, 120))

    return typeEffect
end

return mobskillObject
