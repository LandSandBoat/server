-----------------------------------
-- Enervation
-- Description: Lowers the defense and magical defense of enemies within range.
-- Type: Magical (Dark)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1680 then
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_DOWN
    local defDown    = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 50, 0, 30)
    local mdefDown   = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 50, 0, 30)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

    if defDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.DEFENSE_DOWN
    elseif mdefDown == xi.msg.basic.SKILL_ENFEEB_IS then
        typeEffect = xi.effect.MAGIC_DEF_DOWN
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return typeEffect
end

return mobskillObject
