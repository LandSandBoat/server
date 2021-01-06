----------------------------------------
-- Area: Gustav Tunnel
--   NM: Goblinsavior Heronox
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 423)
end

return entity
