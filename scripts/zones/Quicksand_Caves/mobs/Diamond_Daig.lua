-----------------------------------
-- Area: Quicksand Caves
--   NM: Diamond Daig
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 428)
end

return entity
