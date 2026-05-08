-----------------------------------
-- Barrage
-- Family : Humanoid Job Ability
-- Description : Allows the next ranged attack to fire multiple shots at once.
-- Number of shots fired is determined by the power of the effect.
-- 4 shots at Lv. 30, 5 shots at Lv. 60, 6 shots at Lv. 75 and 7 shots at Lv. 90.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    action:setCategory(xi.action.category.JOBABILITY_FINISH)

    mob:addStatusEffect(xi.effect.BARRAGE, { duration = 60, origin = mob })

    skill:setMsg(xi.msg.basic.USES)

    return xi.effect.BARRAGE
end

return mobskillObject
