-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Cups (WHM)
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
    -- When King of Cups is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId + 1) -- King of Batons
    DespawnMob(mobId + 2) -- King of Swords
    DespawnMob(mobId + 3) -- King of Coins
    SpawnMob(mobId + 4)   -- Queen of Cups
    SpawnMob(mobId + 5)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ABSORB_STATUS)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.BANISH_III,
        xi.magic.spell.BANISHGA_III,
        xi.magic.spell.HOLY,
        xi.magic.spell.DIA_II,
        xi.magic.spell.DIAGA_II,
        xi.magic.spell.HASTE,
        xi.magic.spell.BLINK,
        xi.magic.spell.STONESKIN,
        xi.magic.spell.AQUAVEIL,
        xi.magic.spell.SHELL_IV,
        xi.magic.spell.POISONA,
        xi.magic.spell.BLINDNA,
        xi.magic.spell.CURE_V,
        xi.magic.spell.PARALYZE,
        xi.magic.spell.SLOW,
        xi.magic.spell.SILENCE,
        xi.magic.spell.PROTECT_IV,
        xi.magic.spell.ERASE,
    }
    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
