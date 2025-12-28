-----------------------------------
-- Glacial Breath
-- Family: Wyrms
-- Description: Deals Ice damage to enemies within a fan-shaped area.
-- Notes: Used by Jormungand and Isgebind
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif not target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() == 1 then -- Not used while flying.
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.083
    params.element           = xi.element.ICE
    params.damageCap         = 1400
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = utils.conalDamageAdjustment(mob, target, skill, damage, 0.2)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.ICE)
    end

    return damage
end

return mobskillObject
