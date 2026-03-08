-----------------------------------
-- Eyes on Me
-- Family: Ahriman
-- Description: Deals Dark damage to an enemy. Not affected by % Magic Damage Taken/Shell.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage           = mob:getMainLvl() + 2
    params.fTP                  = { 5, 5, 5 }
    params.element              = xi.element.DARK -- TODO: Capture element (Dark or unaspected?)
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.DARK
    params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipDamageAdjustment = true

    -- TODO: JP Wiki states damage might scale based on distance between mob/target. Need a capture to check.

    if mob:isNM() then
        params.fTP = { 7, 7, 7 }
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
