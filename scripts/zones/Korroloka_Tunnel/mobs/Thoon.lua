-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Thoon
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 229)
end

return entity
