-----------------------------------
-- Poison Sting
-- Induces poison
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
    local typeEffect = xi.effect.POISON

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 5, 3, 180))

    return typeEffect
end

return mobskillObject
