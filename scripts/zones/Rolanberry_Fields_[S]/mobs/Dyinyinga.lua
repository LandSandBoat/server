-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Dyinyinga
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 511)
end

return entity
