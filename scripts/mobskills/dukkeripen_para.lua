-----------------------------------
-- Dukkeripen
-- paralyzes target
-- Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == xi.job.COR then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS

    if xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 120) then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskillObject
