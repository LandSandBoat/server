-----------------------------------
-- Frozen Mist
-- Family: Ruszors
-- Description: Deals Ice damage to enemies around the caster. Additional Effect: Terror
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.5, 1.5, 1.5 }
    params.element        = xi.element.ICE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ICE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 30)
    end

    -- Ice aura that provides special stoneskin that absorbs only physical damage
    skill:setFinalAnimationSub(1)
    mob:delStatusEffectSilent(xi.effect.STONESKIN)
    mob:addStatusEffect(xi.effect.STONESKIN, { duration = 180, origin = mob, subType = 1, subPower = 1500 })

    return info.damage
end

return mobskillObject
