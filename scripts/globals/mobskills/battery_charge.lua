-----------------------------------
-- Battery Charge
-- Description: Gradually restores MP.
-- Type: Magical (Light)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.REFRESH

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 3, 3, 300))

    return typeEffect
end

return mobskillObject
