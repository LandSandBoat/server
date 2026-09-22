-----------------------------------
-- Dream Flower
-- 15' AoE sleep
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- The player doest not wake up from autoattacks from the dynamis version of Dream Flower
    local effectTable =
    {
        [1] = { effectId = xi.effect.SLEEP_I, power = 1, duration = math.randomInt(10, 45), tier = 11 },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
