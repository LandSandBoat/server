-----------------------------------
-- Area: Riverne-Site_A01
-- Notes: Assists Ouryu in Ouryu Cometh
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 500)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRESBUILD, 10)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(120) -- Respawns every 2 minutes, based on in-era video
end

return entity
