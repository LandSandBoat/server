-----------------------------------
-- Area: Ordelles Caves
--   NM: Bombast
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 182)
end

return entity
