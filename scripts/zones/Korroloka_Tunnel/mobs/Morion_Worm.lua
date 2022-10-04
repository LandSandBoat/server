-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Morion Worm
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 1800)
    mob:setMod(xi.mod.REGEN, 5)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
