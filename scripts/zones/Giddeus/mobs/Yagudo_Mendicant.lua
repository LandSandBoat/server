-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Mendicant
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.HOO_MJUU_THE_TORRENT_PH, 5, 3600) -- 1 hour
end
