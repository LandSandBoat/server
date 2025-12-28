-----------------------------------
--  Cackle
--  Reduces magical attack, magical accuracy, and magical defense of targets in an area of effect.
--  Seems to apply all 3 effects, and report the first that it successfully applies: https://youtu.be/T_Us2Tmlm-E?t=206
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffects =
    {
        xi.effect.MAGIC_ATK_DOWN,
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_DEF_DOWN,
    }

    local duration = 60
    local power = 50 -- TODO verify power of debuffs
    local returnResult = 0
    skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    for _, typeEffect in ipairs(typeEffects) do
        if not target:hasStatusEffect(typeEffect) then
            local msg = xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration)

            if
                skill:getMsg() == xi.msg.basic.SKILL_NO_EFFECT and
                msg == xi.msg.basic.SKILL_ENFEEB_IS
            then
                -- report first effect that successfully applied
                skill:setMsg(xi.msg.basic.SKILL_ENFEEB)
                returnResult = typeEffect
            end
        end
    end

    return returnResult
end

return mobskillObject
