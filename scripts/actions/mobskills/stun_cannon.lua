-----------------------------------
-- Stun Cannon
-- Family: Omega
-- Description: Deals Thunder? damage to targets in front of mob. Additional Effect: Paralysis
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if not target:isBehind(mob) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Capture if Magical or Physical
    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 4.50, 4.50, 4.50 } -- TODO: Capture fTPs
    params.element        = xi.element.THUNDER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.THUNDER
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    -- TODO: Capture AoE type

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 120) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
