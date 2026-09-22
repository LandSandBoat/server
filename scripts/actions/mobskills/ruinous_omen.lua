-----------------------------------
-- Ruinous Omen
-- Family: Avatar (Diabolos)
-- Description: Deals damage equal to a random percentage of HP to enemies within area of effect.

-- https://ffxiclopedia.fandom.com/wiki/Ruinous_Omen
-- The prime avatar takes 45 to 90 percent of current HP. One roll per use, never resisted.
-- Ruinous Omen by design cannot KO a target, but can significantly reduce its HP
-- Version used by player summoners seems capped at ~2% except against Behemoths
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- One roll per use. Every target loses the same share.
    if target:getID() == skill:getTargets()[1]:getID() then
        mob:setLocalVar('ruinousOmenRoll', math.randomInt(45, 90))
    end

    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 10, 10, 10 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    -- Stoneskin comes off the share below, not off this flat hit.
    params.skipStoneskin  = not mob:getMaster()

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    -- Mob-summoned avatars keep the flat version. Absorbed and nullified hits keep their result.
    if
        not mob:getMaster() and
        info.damage > 0
    then
        info.damage = utils.handleStoneskin(target, math.floor(target:getHP() * mob:getLocalVar('ruinousOmenRoll') / 100), info.attackType)
    end

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
