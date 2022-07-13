-----------------------------------
-- Area: Balga's Dais
--  Mob: Domovoi
-- BCNM: Steamed Sprouts
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity