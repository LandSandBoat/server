-----------------------------------
-- Area: Quicksand Caves
--   NM: Sabotender Bailarina
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 438)
end

return entity
