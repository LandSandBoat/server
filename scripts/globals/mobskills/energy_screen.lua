-----------------------------------
-- Energy Screen
-- Description: Invincible
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        mob:getStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PHYSICAL_SHIELD

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))

    return typeEffect
end

return mobskillObject
