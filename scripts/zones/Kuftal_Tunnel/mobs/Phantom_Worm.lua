-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Phantom Worm
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGEN, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
