-----------------------------------
-- Dark Shot
-- Qultada
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local dispel = target:dispelStatusEffect(bit.bor(xi.effectFlag.DISPELABLE))

    if dispel == xi.effect.NONE then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return 0
    end

    skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    return 1
end

return mobskillObject
