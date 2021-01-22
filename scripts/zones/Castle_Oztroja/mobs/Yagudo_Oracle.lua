-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Oracle
-- Note: PH for Quu Domi the Gallant
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.QUU_DOMI_THE_GALLANT_PH, 5, 3600) -- 1 hour
end

return entity
