-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Vorpal Bunny
-- Note: PH for Ratatoskr
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.RATATOSKR_PH, 10, 5400) -- 90 minutes
end

return entity
