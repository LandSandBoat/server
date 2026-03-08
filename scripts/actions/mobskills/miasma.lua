-----------------------------------
-- Miasma
-- Family: Mamool Ja (Gulool Ja Ja)
-- Description: Releases a toxic cloud on nearby targets. Additional Effect: Slow, Plague, Poison
-- Notes: Used by Gulool Ja Ja.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 4, 4, 4 }      -- TODO: Capture fTPs
    params.element        = xi.element.EARTH -- TODO: Capture Element
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.EARTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture powers/durations
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, math.floor(mob:getMainLvl() / 3), 3, 60)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 3, 120)
    end

    return info.damage
end

return mobskillObject
