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

    local typeEffect = xi.effect.BLINK

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 3, 0, 180))

    return typeEffect

end

return mobskillObject
