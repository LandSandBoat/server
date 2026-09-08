-----------------------------------
-- Chemical_Bomb
-- Description: slow + elegy
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectTable =
    {
        [1] = { effectId = xi.effect.ELEGY, power = 5000, duration = 120           },
        [2] = { effectId = xi.effect.SLOW,  power = 5000, duration = 120, tier = 8 },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
