-----------------------------------
-- Bubble Shower
-- Family: Crabs
-- Description: Deals Water damage in an area of effect. Additional Effect: STR Down
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.0625
    params.element           = xi.element.WATER
    params.damageCap         = 200
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    -- TODO: Jug Pet differences

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.WATER)

        local power    = 10
        local duration = 180
        -- TODO: Dreamland Dynamis Power

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 9, duration)
    end

    return damage
end

return mobskillObject
