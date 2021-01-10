-----------------------------------
-- Area: Rolanberry Fields
--   NM: Drooling Daisy
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 216)
end

return entity
