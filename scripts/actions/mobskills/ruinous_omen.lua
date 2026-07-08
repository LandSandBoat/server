-----------------------------------
-- Ruinous Omen
-- Family: Avatar (Diabolos)
-- Description: Deals damage equal to a random percentage of HP to enemies within area of effect.

-- https://ffxiclopedia.fandom.com/wiki/Ruinous_Omen
-- Prime Avatar seems to do an unresisted ~66% HP reduction from players' current HP (not max HP)
-- Ruinous Omen by design cannot KO a target, but can significantly reduce its HP
-- Version used by player summoners seems capped at ~2% except against Behemoths
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 10, 10, 10 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
