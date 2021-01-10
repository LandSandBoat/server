------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Tethra
------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 496)
end

return entity
