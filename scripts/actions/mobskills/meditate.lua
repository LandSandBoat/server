-----------------------------------
-- Meditate
-- Gradually charges TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    action:setCategory(xi.action.category.JOBABILITY_FINISH)

    mob:addStatusEffect(xi.effect.MEDITATE, { power = 20, duration = 15, tick = 3, origin = mob, icon = 0 })

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.MEDITATE
end

return mobskillObject
