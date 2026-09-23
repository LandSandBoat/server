-----------------------------------
-- Scream
-- 15' Reduces MND of players in area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectTable =
    {
        [1] = { effectId = xi.effect.MND_DOWN, power = 21, tick = 3, duration = 180 },
        [2] = { effectId = xi.effect.TERROR,   power = 1,  duration = math.randomInt(2, 5) },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
