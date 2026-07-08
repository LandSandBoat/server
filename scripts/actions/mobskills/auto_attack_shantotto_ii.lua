-----------------------------------
--  Shantotto II Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg() -- TODO: capture damage
    params.fTP            = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Capture shadowBehavior
    params.primaryMessage = xi.msg.basic.HIT_DMG
    -- Note: Element might be adaptive to target weakness.
    -- Using Shantotto II vs ROV Siren, the auto attacks were healing the mob(Siren absorbs Wind element damage).

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
