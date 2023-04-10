-----------------------------------
-- Refueling
-- Increases attack speed.
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
    local typeEffect = xi.effect.HASTE
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1000, 0, 300))
    return typeEffect
end

return mobskillObject
