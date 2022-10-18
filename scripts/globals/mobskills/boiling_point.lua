-----------------------------------
-- Boiling Point
--
-- Description: Reduces magic defense in a fan-shaped area of effect.
-- Type: Magical
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
    local typeEffect = xi.effect.MAGIC_DEF_DOWN
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 180))
    return typeEffect
end

return mobskillObject
