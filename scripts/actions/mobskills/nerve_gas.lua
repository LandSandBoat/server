-----------------------------------
-- Nerve Gas
-- Family: Hydras
-- Description: Deals Magic (Element unknown) damage to targets around mob. Additional Effect: Curse, Poison
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Use conditions vary by mob. Maybe move to mob script if possible?
    if mob:getFamily() == 313 then -- Tinnin can use at will
        return 0
    else
        if mob:getAnimationSub() == 0 then -- 3 Heads
            return 0
        else
            return 1
        end
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.0, 1.0, 1.0 }                        -- TODO: Capture fTPs
    params.element        = xi.element.NONE                          -- TODO: Capture element (Water or None?)
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ELEMENTAL                  -- TODO: Match with element capture
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CURSE_I, 50, 0, 420)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 20, 3, 60)
    end

    return info.damage
end

return mobskillObject
