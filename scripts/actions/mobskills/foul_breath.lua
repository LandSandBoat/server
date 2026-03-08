-----------------------------------
-- Foul Breath
-- Family: Raptors
-- Description: Deals Fire damage to enemies within a fan-shaped area originating from the caster. Additional Effect: Disease
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Not used in Uleguerand_Range
    -- TODO: Handle this with a proper skill list.
    if mob:getZoneID() == 5 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.083
    params.damageCap        = 500
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.FIRE
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.FIRE
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 180)
    end

    return info.damage
end

return mobskillObject
