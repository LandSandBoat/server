-----------------------------------
-- Fiery Breath
-- Family: Wyrms (Tiamat)
-- Description: Deals Fire damage to enemies within a fan-shaped area.
-- Notes: Used only by Tiamat, Smok and Ildebrann
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) then
        return 1
    elseif not target:isInfront(mob, 128) then
        return 1
    elseif mob:getAnimationSub() == 1 then -- Do not use while flying
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.2
    params.damageCap        = 1400
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.LIGHT
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.LIGHT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    info.damage = utils.conalDamageAdjustment(mob, target, skill, info.damage, 0.9)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
