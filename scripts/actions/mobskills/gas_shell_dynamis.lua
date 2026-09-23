-----------------------------------
-- Gas Shell
--
-- Description: Releases a toxic gas from its shell, poisoning and applying Gravity to targets in an area of effect.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local effectTable =
    {
        [1] = { effectId = xi.effect.POISON, power = 50, duration = 180, tier = 0 },
        [2] = { effectId = xi.effect.WEIGHT, power = 50, duration = 45,  tier = 0 },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
