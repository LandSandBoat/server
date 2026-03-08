-----------------------------------
-- Gigaflare
-- Family: Bahamut
-- Description: Deals massive Fire damage to enemies within a fan-shaped area.
-- Notes: Used by Bahamut when at 10% of its HP, and can use anytime afterwards at will.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: This logic should probably be in mob script.
    local mobhp = mob:getHPP()

    if mobhp <= 10 then -- Set up Gigaflare for being called by the script again.
        mob:setLocalVar('GigaFlare', 0)
        mob:setMobAbilityEnabled(false) -- Disable mobskills/spells until Gigaflare is used successfully (don't want to delay it/queue Megaflare)
        mob:setMagicCastingEnabled(false)
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl()
    params.fTP             = { 14, 14, 14 }
    params.element         = xi.element.FIRE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.FIRE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1.5

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    -- Targets that are not the primary target take 300 less damage.
    if
        target:getID() ~= skill:getPrimaryTargetID() and
        info.damage > 0 -- Damage was not nullified or absorbed.
    then
        info.damage = math.max(0, info.damage - 300)
    end

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    -- TODO: This logic can probably be in the mob script.
    mob:setLocalVar('GigaFlare', 1) -- When set to 1 the script won't call it.
    mob:setLocalVar('tauntShown', 0)
    mob:setMobAbilityEnabled(true) -- Enable the spells/other mobskills again
    mob:setMagicCastingEnabled(true)

    if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) == 0 then -- re-enable noturn
        mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    end

    return info.damage
end

return mobskillObject
