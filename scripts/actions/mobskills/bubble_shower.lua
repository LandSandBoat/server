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

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.0625
    params.damageCap        = 200
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.WATER
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.WATER
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    -- TODO: Jug Pet differences

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power    = 10
        local duration = 180
        -- TODO: Dreamland Dynamis Power

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 9, duration)
    end

    return info.damage
end

return mobskillObject
