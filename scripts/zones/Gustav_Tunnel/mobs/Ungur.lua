----------------------------------------
-- Area: Gustav Tunnel
--   NM: Ungur
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 475)
end

return entity
