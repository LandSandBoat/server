-----------------------------------
-- Mind Blast
-- Family: Soulflayers
-- Description: Deals Thunder damage to an enemy. Additional Effect: Paralysis
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 2.0, 2.0, 2.0 }
    params.element         = xi.element.THUNDER
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.THUNDER
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1.5

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture Paralysis power. Sources say its extremely potent.
        -- TODO: More captures for duration to account for effect resistance.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, xi.mobskills.calculateDuration(skill:getTP(), 15, 45))
    end

    return info.damage
end

return mobskillObject
