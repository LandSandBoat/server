-----------------------------------
-- Pyric Bulwark
-- Description: Grants a Physical Shield effect for a time.
-- Type: Enhancing
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() <= 1 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 0, 1, 0, 45) -- addStatusEffectEx to pervent dispel.

    return xi.effect.PHYSICAL_SHIELD
end

return mobskillObject
