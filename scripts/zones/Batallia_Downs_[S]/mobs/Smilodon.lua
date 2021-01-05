-----------------------------------
-- Area: Batallia Downs [S]
--  Mob: Smilodon
-- Note: PH for La Velue
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.LA_VELUE_PH, 10, 3600) -- 1 hour
end

return entity
