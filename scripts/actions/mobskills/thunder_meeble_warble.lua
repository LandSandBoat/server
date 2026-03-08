-----------------------------------
-- Thunder Meeble Warble
-- Family: Meebles
-- Description: AOE Lightning Elemental damage, inflicts Stun and Shock (50 HP/tick).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 18.00, 18.00, 18.00 } -- TODO: Capture fTPs
    params.element        = xi.element.THUNDER
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.THUNDER
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effect power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SHOCK, 50, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 30, 0, 15)
    end

    return info.damage
end

return mobskillObject
