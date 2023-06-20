-----------------------------------
-- Harden Shell
-- Description: Enhances defense.
-- Type: Magical (Earth)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 100, 0, 60))
    return typeEffect
end

return mobskillObject
