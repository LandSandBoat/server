-----------------------------------
-- Heliovoid
-- Description: Absorbs one status effect from all players in range.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores
-- Range: AoE
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.EFFECT_DRAINED)

    if mob:stealStatusEffect(target) ~= 0 then
        return 1
    end

    skill:setMsg(xi.msg.basic.SKILL_MISS)
    return 0
end

return mobskillObject
