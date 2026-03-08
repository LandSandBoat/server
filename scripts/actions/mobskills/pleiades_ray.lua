-----------------------------------
-- Pleiades Ray
-- Family: Trolls
-- Description: Fires a magical ray at nearby targets. Additional Effects: Paralysis + Blind + Poison + Plague + Bind + Silence + Slow
-- Notes: Only used by Gurfurlur the Menacing with health below 20%.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Handle via mob scripts?
    local mobhp = mob:getHPP()

    if mobhp <= 20 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 7.0, 7.0, 7.0 } -- TODO: Capture fTPs
    params.element        = xi.element.FIRE   -- TODO: Capture element
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.FIRE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture power/durations of status effects.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 40, 3, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 40, 3, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 10, 3, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 120)
    end

    return info.damage
end

return mobskillObject
