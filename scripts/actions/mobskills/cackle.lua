-----------------------------------
--  Cackle
--  Reduces magical attack, magical accuracy, or magical defense of targets in an area of effect.
-- Video evidence that it's only ever one effect applied to all targets in AoE: https://youtu.be/T_Us2Tmlm-E?t=206
-----------------------------------
local mobskillObject = {}

local typeEffects =
{
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_ACC_DOWN,
    xi.effect.MAGIC_DEF_DOWN,
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- smaller range to use, but 30 yalm AoE. Effectively cannot out-range the skill
    if mob:checkDistance(target) > 10 then
        return 1
    end

    mob:setLocalVar('cackle-index', math.random(1, #typeEffects))
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 40
    local duration = 60
    local returnEffect = xi.effect.NONE
    local typeEffect = typeEffects[mob:getLocalVar('cackle-index')]

    skill:setMsg(xi.msg.basic.SKILL_MISS)
    if xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration) == xi.msg.basic.SKILL_ENFEEB_IS then
        returnEffect = typeEffect
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    end

    return returnEffect
end

return mobskillObject
