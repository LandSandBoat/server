-----------------------------------
-- Stupor Spores
-- Family: Euvhi
-- Description: Spreads intoxicating spores that damages nearby targets. Additional Effect: Sleep
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 1.00, 1.00, 1.00 }
    params.element         = xi.element.NONE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.ELEMENTAL
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.random(15, 60))
    end

    return info.damage
end

return mobskillObject
