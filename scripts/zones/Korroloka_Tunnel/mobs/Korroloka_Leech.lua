-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Korroloka Leech
-- Involved in Quest: Ayame and Kaede
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

return entity
