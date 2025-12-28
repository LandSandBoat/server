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

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.083
    params.element           = xi.element.FIRE
    params.damageCap         = 500
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.FIRE)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 180)
    end

    return damage
end

return mobskillObject
