-----------------------------------
-- Polar Bulwark
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 45) -- addStatusEffectEx to pervent dispel.

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
