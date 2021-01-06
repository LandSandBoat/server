-----------------------------------
-- Area: Xarcabard [S]
--   NM: Tikbalang
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 540)
end

return entity
