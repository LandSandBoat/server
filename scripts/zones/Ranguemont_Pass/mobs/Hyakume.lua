-----------------------------------
-- Area: Ranguemont Pass
--   NM: Hyakume
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: This might be able to spawn off itself in a spawn slot
-- TODO: figure out Dread Spikes, they don't seem to be traditional drain spikes (resists are not dmg * 1/(2^X))
-- TODO: better proc rate of Curse. Current data: 19 procs over (436 normal hits + 25 crits) = 19/(432+25) = 4.1%~ = probably 5%?. Confidence interval = 2.327%~5.988%.
--       Curse data collected on ilvl 119 character
-- TODO: More spawn points
entity.phList =
{
    [ID.mob.HYAKUME - 7] = ID.mob.HYAKUME, -- PH is 0x4D
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 85)                       -- 8 hits to 1k tp
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)                 -- from capture
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150) -- Guessed
    mob:setMagicCastingEnabled(false)                    -- Has MP, doesn't cast spells

    mob:setAggressive(true)                                -- Enable aggro
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.HEARING) -- Set sound aggro
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 5,
        effectId = xi.effect.CURSE_I,
        power    = 13, -- 12.5% max HP/MP down exactly. We don't support float here (yet) so use 13%.
        duration = 64, -- Guessed. there was an 8~ second resist and a 16~ second resist. Could be 32 seconds?
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.HEX_EYE
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 344)
    xi.magian.onMobDeath(mob, player, optParams, set{ 778 })
end

return entity
