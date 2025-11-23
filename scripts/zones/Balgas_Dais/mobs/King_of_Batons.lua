-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Batons (BLM)
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
    -- When King of Batons is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 1) -- King of Cups
    DespawnMob(mobId + 1) -- King of Swords
    DespawnMob(mobId + 2) -- King of Coins
    SpawnMob(mobId + 3)   -- Queen of Cups
    SpawnMob(mobId + 4)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { power = math.random(25, 125) })
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.FIRE_IV,
        xi.magic.spell.BLIZZARD_IV,
        xi.magic.spell.AERO_IV,
        xi.magic.spell.THUNDER_IV,
        xi.magic.spell.WATER_IV,
        xi.magic.spell.FIRAGA_III,
        xi.magic.spell.THUNDAGA_III,
        xi.magic.spell.SLEEP,
        xi.magic.spell.SLEEP_II,
        xi.magic.spell.SLEEPGA,
        xi.magic.spell.SLEEPGA_II,
        xi.magic.spell.BLIND,
        xi.magic.spell.BIND,
        xi.magic.spell.BURN,
        xi.magic.spell.SHOCK,
        xi.magic.spell.CHOKE,
        xi.magic.spell.BIO_II,
        xi.magic.spell.POISONGA_II,
        xi.magic.spell.STUN,
        xi.magic.spell.DRAIN,
        xi.magic.spell.ASPIR,
        xi.magic.spell.BLAZE_SPIKES,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
