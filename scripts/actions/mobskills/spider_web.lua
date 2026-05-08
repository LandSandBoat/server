-----------------------------------
-- Spider Web
-- Entangles all targets in an area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectTable =
    {
        [1] = { effectId = xi.effect.SLOW, power = 3000, duration = 90, tier = 8, },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
