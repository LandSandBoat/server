-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Novv the Whitehearted
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -37.000, y = 19.000, z = -205.000 },
    { x = -18.396, y = 20.241, z = -204.176 },
    { x = -18.650, y = 20.260, z = -194.711 },
    { x = -11.683, y = 20.347, z = -211.369 },
    { x =  -2.334, y = 20.584, z = -203.761 },
    { x =  -5.876, y = 20.313, z = -183.527 }
}

entity.phList =
{
    [ID.mob.NOVV_THE_WHITEHEARTED - 1] = ID.mob.NOVV_THE_WHITEHEARTED,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 4800)
    mob:setMobMod(xi.mobMod.GIL_MAX, 4800)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
