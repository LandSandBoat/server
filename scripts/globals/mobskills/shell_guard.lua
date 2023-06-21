-----------------------------------
-- Shell Guard
-- Increases defense of user.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local base = 100
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, base, 0, 180))
    return typeEffect
end

return mobskillObject
