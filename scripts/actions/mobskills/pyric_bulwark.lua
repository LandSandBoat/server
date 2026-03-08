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

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    mob:addStatusEffect(xi.effect.PHYSICAL_SHIELD, { power = 1, duration = 45, origin = mob, icon = 0 })

    return xi.effect.PHYSICAL_SHIELD
end

return mobskillObject
