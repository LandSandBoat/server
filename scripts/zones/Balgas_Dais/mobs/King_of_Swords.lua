-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Swords (PLD)
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
    -- When King of Swords is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 2) -- King of Cups
    DespawnMob(mobId - 1) -- King of Batons
    DespawnMob(mobId + 1) -- King of Coins
    SpawnMob(mobId + 2)   -- Queen of Cups
    SpawnMob(mobId + 3)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ATTACK_DOWN)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.PROTECT_IV,
        xi.magic.spell.SHELL_III,
        xi.magic.spell.BANISH_II,
        xi.magic.spell.CURE_IV,
        xi.magic.spell.FLASH,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
