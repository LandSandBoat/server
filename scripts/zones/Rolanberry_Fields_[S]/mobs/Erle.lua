-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Erle
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 512)
end

return entity
