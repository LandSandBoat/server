-----------------------------------
-- Area: Valkurm Dunes
--   NM: Valkurm Emperor
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 209)
end

return entity
