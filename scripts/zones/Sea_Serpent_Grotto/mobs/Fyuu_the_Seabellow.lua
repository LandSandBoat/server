-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Fyuu the Seabellow
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  175.000, y =  20.000, z =  41.000 }
}

entity.phList =
{
    [ID.mob.FYUU_THE_SEABELLOW - 3] = ID.mob.FYUU_THE_SEABELLOW, -- 185.074 20.252 39.317
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 2400)
    mob:setMobMod(xi.mobMod.GIL_MAX, 2400)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    mob:setMod(xi.mod.SONG_SPELLCASTING_TIME, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 372)
end

return entity
