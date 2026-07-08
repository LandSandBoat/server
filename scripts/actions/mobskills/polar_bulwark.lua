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

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    mob:addStatusEffect(xi.effect.MAGIC_SHIELD, { power = 1, duration = 45, origin = mob, icon = 0 })

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
