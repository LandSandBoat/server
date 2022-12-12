-----------------------------------
-- Area: Balga's Dais
--  Mob: Myrmidon Apu-apu
-- BCNM: Royal Succession
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEP_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
