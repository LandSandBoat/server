-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Corrupted Ulbrig
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMod(xi.mod.SLEEP_MEVA, 50)
    mob:setMod(xi.mod.LULLABY_MEVA, 50)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
