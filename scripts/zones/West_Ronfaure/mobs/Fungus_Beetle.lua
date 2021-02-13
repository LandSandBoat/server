-----------------------------------
-- Area: West Ronfaure (100)
--   NM: Fungus Beetle
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 147)
end

return entity
