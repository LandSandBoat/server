-----------------------------------
-- Berserk
-- Berserk Ability.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BERSERK
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 180))
    return typeEffect
end

return mobskillObject
