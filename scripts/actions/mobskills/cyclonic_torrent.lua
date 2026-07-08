-----------------------------------
-- Cyclonic Torrent
-- Family: Pixies
-- Description: Deals Wind damage to targets in range. Additional Effect: Mute
-- Notes: Used by Urd, Verthandi, and Carabosse.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
    params.element        = xi.element.WIND
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MUTE, 1, 0, 60)
    end

    return info.damage
end

return mobskillObject
