-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Dog Guardian
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 35) -- 10 hits to 1k tp
end

return entity
