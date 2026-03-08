-----------------------------------
-- Gregale Wing
-- Family: Wyrms
-- Description: An icy wind deals Ice damage to enemies within a very wide area of effect. Additional Effect: Paralyze
-- Notes: Used by Jormungand and Isgebind
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) then
        return 1
    elseif mob:getAnimationSub() == 1 then -- Only use while on ground
        return 1
    elseif target:isBehind(mob, 48) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 4, 4, 4 } -- TODO: Capture fTPs
    params.element        = xi.element.ICE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ICE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 0, 120)
    end

    return info.damage
end

return mobskillObject
