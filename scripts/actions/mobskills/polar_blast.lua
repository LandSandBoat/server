-----------------------------------
-- Polar Blast
-- Family: Hydra
-- Description: Deals Ice damage to enemies within a fan-shaped area. Additional Effect: Paralyze
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() <= 1 then
        -- TODO: Does this need an inFront() check?
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.01 -- TODO: Capture breath values.
    params.damageCap        = 700 -- TODO: Capture cap
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.ICE
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.ICE
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 0, 60) -- TODO: Capture power and duration
    end

    if
        mob:getFamily() == 313 and
        bit.band(mob:getBehavior(), xi.behavior.NO_TURN) == 0 and
        mob:getAnimationSub() == 1
    then
        -- Re-enable no turn if third head is dead (Tinnin), else it's re-enabled after the upcoming Pyric Blast
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    return info.damage
end

return mobskillObject
