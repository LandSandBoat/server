-----------------------------------
-- Area: Quicksand Caves
--   NM: Sabotender Bailarina
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 433)
end

return entity
