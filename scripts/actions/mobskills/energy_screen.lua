-----------------------------------
-- Energy_Screen
-- Description: Invincible
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('citadelBuster') == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PHYSICAL_SHIELD

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))

    return typeEffect
end

return mobskillObject
