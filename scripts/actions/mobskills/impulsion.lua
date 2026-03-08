-----------------------------------
-- Impulsion
-- Family: Bahamut
-- Description: Deals unaspected magical damage to enemies within an area of effect. Additional Effects: Blind, Knockback, Petrification
-- Note: Used by Bahamut in The Wyrmking Descends
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl()
    params.fTP            = { 2.75, 2.75, 2.75 }
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS -- TODO: Capture shadowBehavior
    -- TODO: Capture Knockback

    -- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit?pli=1&gid=57955395#gid=57955395&range=A915
    -- TODO: Once Gigaflare is available for use, the fTP of this skill increases to 5.50.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local petrifyDuration = 15
        -- TODO: Once Gigaflare is available for use, the duration of petrification increases to 30.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, petrifyDuration)

        -- TODO: Confirm Blind effect, power/duration.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 15, 0, 60)
    end

    return info.damage
end

return mobskillObject
