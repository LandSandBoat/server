-----------------------------------
-- Typhoon Wing
-- Family: Wyrms
-- Description: Deals Wind? damage to enemies within a very wide area of effect. Additional Effect: Blind
-- Notes: Used by Ouryu and Dragua. The blinding effect does not last long
--        but is very harsh. The attack is wide enough to generally hit an entire alliance.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    elseif mob:getAnimationSub() ~= 0 then -- Do not use while flying
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 4.50, 5.00, 5.50 }
    params.element        = xi.element.WIND -- TODO: Capture element
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 60, 0, 30) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
