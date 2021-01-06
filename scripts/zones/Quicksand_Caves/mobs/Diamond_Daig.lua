-----------------------------------
-- Area: Quicksand Caves
--   NM: Diamond Daig
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 428)
end

return entity
