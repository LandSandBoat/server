-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Hoarder Hare
-- Note: PH for Teporingo
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TEPORINGO_PH, 20, 3600) -- 1 hour
end

return entity
