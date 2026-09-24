-----------------------------------
-- Sonic Wave
-- Reduces defense of enemies in an area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectTable =
    {
        [1] = { effectId = xi.effect.DEFENSE_DOWN, power = 50, duration = 240 },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
