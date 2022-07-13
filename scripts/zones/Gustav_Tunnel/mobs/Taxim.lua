-----------------------------------
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ICE_MEVA, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 424)
end

return entity
