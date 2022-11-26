-----------------------------------
-- Area: Rolanberry Fields (110)
--   NM: Silk Caterpillar (Spawning handled in Zone.lua)
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 210) -- 3.5 minutes
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
