-----------------------------------
-- Area: Sea Serpent Grotto (176)
--   NM: Charybdis
-- !pos -152 48 -328 176
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.MULTI_HIT, 5)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
