-----------------------------------
-- Area: RoMaeve
--   NM: Mokkurkalfi
-- Note: spawned during mission "The Final Image"
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
