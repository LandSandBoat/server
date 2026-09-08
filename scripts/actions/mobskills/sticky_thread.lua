-----------------------------------
-- Sticky Thread
-- Inflicts slow on targets in a fan-shaped area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 180, 540)

    local effectTable =
    {
        [1] = { effectId = xi.effect.SLOW, power = 5000, duration = duration, tier = 1 },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
