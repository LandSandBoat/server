-----------------------------------
-- Thunderbolt Breath
-- Family: Raptors
-- Description: Deals Thunder damage to enemies within a fan-shaped area originating from the caster.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Not used in Uleguerand_Range
    if mob:getZoneID() == 5 then -- TODO: Set Skill lists
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.0833
    params.element           = xi.element.THUNDER
    params.damageCap         = 500
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.THUNDER)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 7)
    end

    return damage
end

return mobskillObject
