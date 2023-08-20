-----------------------------------
-- Dissipation
-- Dispels all buffs add terror effect
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 10)

    local count = target:dispelAllStatusEffect()

    if count == 0 then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    end

    return count
end

return mobskillObject
