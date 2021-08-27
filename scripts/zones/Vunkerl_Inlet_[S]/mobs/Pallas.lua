-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallas
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 489)
end

return entity
