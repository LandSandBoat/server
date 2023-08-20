-----------------------------------
-- Subsonics
-- Lower defense
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 25, 0, 180))
    return typeEffect
end

return mobskillObject
