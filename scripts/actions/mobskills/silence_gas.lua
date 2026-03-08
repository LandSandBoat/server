-----------------------------------
-- Silence Gas
-- Family: Funguar
-- Description: Deals Dark Breath damage to targets in front of mob. Additional Effect: Silence
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.25
    params.damageCap        = 800 -- TODO: Capture cap
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.DARK
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.DARK
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Jugpet Differences
        local duration = math.random(15, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration)
    end

    return info.damage
end

return mobskillObject
