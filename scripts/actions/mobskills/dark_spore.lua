-----------------------------------
-- Dark Spore
-- Family: Funguar
-- Description: Unleashes a torrent of black spores in a fan-shaped area of effect, dealing Dark damage to targets. Additional Effect: Blind
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.25
    params.damageCap        = 600 -- TODO: Capture damage cap.
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

        local duration = 90
        -- TODO: Jugpet Differences

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, duration)
    end

    return info.damage
end

return mobskillObject
