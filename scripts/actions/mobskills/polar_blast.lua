-----------------------------------
-- Polar Blast
-- Family: Hydra
-- Description: Deals Ice damage to enemies within a fan-shaped area. Additional Effect: Paralyze
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then -- TODO: Pandemonium Warden, Set skill lists
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    end

    if mob:getAnimationSub() <= 1 then
        -- TODO: Does this need an inFront() check?
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.01 -- TODO: Capture breath values.
    params.element           = xi.element.ICE
    params.damageCap         = 700 -- TODO: Capture cap
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.ICE)

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

    return damage
end

return mobskillObject
