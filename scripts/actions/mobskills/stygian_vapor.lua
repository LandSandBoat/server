-----------------------------------
-- Stygian Vapor
-- Description: AoE Powerful plague
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 0, 120)

    if typeEffect == nil then
        typeEffect = xi.msg.basic.SKILL_NO_EFFECT
    end

    skill:setMsg(typeEffect)

    return xi.effect.PLAGUE
end

return mobskillObject
