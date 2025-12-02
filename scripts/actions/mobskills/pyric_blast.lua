-----------------------------------
-- Pyric Blast
-- Family: Hydra
-- Description: Deals Fire damage to enemies within a fan-shaped area. Additional Effect: Plague
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Only used when all 3 heads are alive.
    if mob:getAnimationSub() == 0 then
        -- TODO: Does this need an inFront() check?
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.01 -- TODO: Capture breath values.
    params.element           = xi.element.FIRE
    params.damageCap         = 700 -- TODO: Capture cap
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.FIRE)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60) -- TODO: Capture power/duration
    end

    if
        mob:getFamily() == 313 and
        bit.band(mob:getBehavior(), xi.behavior.NO_TURN) == 0
    then
        -- re-enable no turn if all three heads are up
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    return damage
end

return mobskillObject
