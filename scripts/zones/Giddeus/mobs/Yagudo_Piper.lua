-----------------------------------
-- Area: Giddeus (145)
--  Mob: Yagudo Piper
-- Note: PH for Vuu Puqu the Beguiler
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VUU_PUQU_THE_BEGUILER_PH, 5, 900) -- 15 minutes
end

return entity
