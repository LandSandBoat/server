-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Coins (RDM)
-- KSNM: Royale Ramble
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

entity.onMobEngage = function(mob, target)
    -- When King of Coins is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 3) -- King of Cups
    DespawnMob(mobId - 2) -- King of Batons
    DespawnMob(mobId - 1) -- King of Swords
    SpawnMob(mobId + 1)   -- Queen of Cups
    SpawnMob(mobId + 2)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.DISPEL)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.FIRE_III,
        xi.magic.spell.BLIZZARD_III,
        xi.magic.spell.AERO_III,
        xi.magic.spell.WATER_III,
        xi.magic.spell.THUNDER_III,
        xi.magic.spell.STONE_IV,
        xi.magic.spell.BIO_III,
        xi.magic.spell.POISON_II,
        xi.magic.spell.DIA_II,
        xi.magic.spell.DIAGA_II,
        xi.magic.spell.BIND,
        xi.magic.spell.GRAVITY,
        xi.magic.spell.SLEEP,
        xi.magic.spell.SLEEP_II,
        xi.magic.spell.SLOW,
        xi.magic.spell.PARALYZE,
        xi.magic.spell.DISPEL,
        xi.magic.spell.BLIND,
        xi.magic.spell.PROTECT_IV,
        xi.magic.spell.SHELL_IV,
        xi.magic.spell.BLINK,
        xi.magic.spell.STONESKIN,
        xi.magic.spell.AQUAVEIL,
        xi.magic.spell.HASTE,
        xi.magic.spell.REGEN,
        xi.magic.spell.ENWATER,
        xi.magic.spell.CURE_IV,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
