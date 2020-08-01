-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Oracle
-- Note: PH for Quu Domi the Gallant
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.QUU_DOMI_THE_GALLANT_PH, 5, 3600) -- 1 hour
end
