-----------------------------------
-- Immortal Shield
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    mob:addStatusEffect(xi.effect.MAGIC_SHIELD, { origin = mob, tick = 1, subType = 45 })
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
