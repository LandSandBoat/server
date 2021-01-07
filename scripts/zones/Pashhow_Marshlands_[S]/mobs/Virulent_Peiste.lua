-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Virulent Peiste
-- Note: PH for Sugaar
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.SUGAAR_PH, 5, 3600) -- 1 hour
end

return entity
