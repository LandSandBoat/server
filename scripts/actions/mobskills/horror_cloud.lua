-----------------------------------
-- Horror Cloud
--
-- Description: A debilitating cloud slows the attack speed of a single target.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: Can be overwritten and blocked by Haste.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 60, 300)

    local effectTable =
    {
        [1] = { effectId = xi.effect.SLOW, power = 5000, duration = duration, tier = 1 },
    }

    return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
end

return mobskillObject
