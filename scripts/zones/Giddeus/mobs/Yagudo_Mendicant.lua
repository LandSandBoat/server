-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Mendicant
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HOO_MJUU_THE_TORRENT_PH, 12, 3600) -- 1 hour
end

return entity
