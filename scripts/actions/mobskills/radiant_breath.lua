-----------------------------------
-- Radiant Breath
-- Family: Wyverns
-- Description: Deals Light damage to enemies within a fan-shaped area of effect originating from the mob. Additional Effect: Silence, Slow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.125
    params.damageCap        = 700
    params.bonusDamage      = (mob:getMainLvl() + 2) * 2
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT -- TODO: Light based skills are often MND, need captures.
    params.element          = xi.element.LIGHT
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.LIGHT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

         -- TODO: Function name is duration. We might want to rename to something more universal.
        local power = xi.mobskills.calculateDuration(skill:getTP(), 1250, 1250) -- TODO: Capture power values

        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW,    power = power, duration = 120, tier = 1 },
            [2] = { effectId = xi.effect.SILENCE, power =     1, duration = 120           },
        }

        xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, { messageBypass = true })
    end

    return info.damage
end

return mobskillObject
