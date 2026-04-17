-----------------------------------
-- Grating Tantara
-- Family: Imp
-- Description: Deals damage to targets in range. Additional Effect: Amnesia
-- Utsusemi/Blink absorb: Strips shadows
-- Range: 10' as well as single target outside of 10'
-- Notes: Doesn't use this if its horn is broken. Used only by certain Imp NMs, in place of Abrasive Tantara.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() == 5 and
        mob:getFamily() == 165
    then -- Imps without horn
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Capture if magical or physical
    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 60) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
