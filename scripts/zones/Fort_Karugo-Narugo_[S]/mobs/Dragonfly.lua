-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--  Mob: Dragonfly
-- Note: PH for Demoiselle Desolee
-----------------------------------
local ID = require("scripts/zones/Fort_Karugo-Narugo_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DEMOISELLE_DESOLEE_PH, 5, 3600) -- 1 hour
end

return entity
