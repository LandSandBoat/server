-----------------------------------
-- Area: East Ronfaure [S]
--   NM: Skogs Fru
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 479)
end

return entity
