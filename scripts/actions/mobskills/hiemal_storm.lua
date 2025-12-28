-----------------------------------
-- Hiemal Storm
-- Family: Snoll
-- Description: Extreme directional AoE ice damage for 200-1400 points
-- Notes: Used by Snoll Tzar
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.382 -- TODO: Capture value.
    params.element           = xi.element.ICE
    params.damageCap         = 1300 -- TODO: Capture damage cap.
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = utils.conalDamageAdjustment(mob, target, skill, damage, 0.9) -- TODO: Does this have a conal adjustment?
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.ICE)
    end

    return damage
end

return mobskillObject
