-----------------------------------
-- Area: Ordelles Caves
--   NM: Bombast
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 182)
end

return entity
