-----------------------------------
-- Area: Gusgen Mines
--   NM: Wandering Ghost
-- Involved In Quest: Ghosts of the Past
-- !pos -174 0.1 369 196
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
