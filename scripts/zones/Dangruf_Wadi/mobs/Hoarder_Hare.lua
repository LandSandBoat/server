-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Hoarder Hare
-- Note: PH for Teporingo
-----------------------------------
local ID = require("scripts/zones/Dangruf_Wadi/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.TEPORINGO_PH, 20, 3600) -- 1 hour
end

return entity
