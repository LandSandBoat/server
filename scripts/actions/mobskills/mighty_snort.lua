-----------------------------------
-- Mighty Snort
-- Family: Buffalo
-- Description: Deals Wind damage to targets in a fan-shaped area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 4.00, 4.00, 4.00 }
    params.element         = xi.element.WIND
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WIND
    params.shadowBehavior  = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier = 1
    -- TODO: Capture Knockback

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: NM: Audumbla reportedly has hate reset on this skill.
    end

    return info.damage
end

return mobskillObject
