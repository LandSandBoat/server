----------------------------------------
-- Area: Gustav Tunnel
--   NM: Amikiri
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 473)
end

return entity
