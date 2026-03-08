-----------------------------------
-- Vulcan Shot
-- Family: Fomor
-- Description: Fires an explosive bullet at targets in an area of effect.
-- Notes: Used by Ashu Talif Captain, possibly others.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_WS, 0, 254) -- TODO: Needed?

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Verify if magical or physical skill
    -- TODO: Capture AoE Type or Single hit.
    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 32.00, 32.00, 32.00 } -- TODO: Capture fTPs (Original code was Weapon Damage * 4 * 8)
    params.element        = xi.element.FIRE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior
    -- TODO: Need animation ID capture

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
