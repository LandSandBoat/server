-----------------------------------
-- Aqua Breath
-- Family: Adamantoise
-- Description: Deals Water damage to enemies within a fan-shaped area.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.10
    params.element           = xi.element.WATER
    params.damageCap         = 500
    params.bonusDamage       = 100
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.WATER)
    end

    return damage
end

return mobskillObject
