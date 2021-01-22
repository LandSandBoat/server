-----------------------------------
-- Area: East Ronfaure [S]
--   NM: Skogs Fru
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 479)
end

return entity
