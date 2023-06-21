-----------------------------------
-- Infrasonics
-- Reduces evasion of targets in area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.EVASION_DOWN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 120))

    return typeEffect
end

return mobskillObject
