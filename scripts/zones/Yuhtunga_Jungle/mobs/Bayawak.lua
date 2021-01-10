-----------------------------------
-- Area: Yuhtunga Jungle
--   NM: Bayawak
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 363)
end

return entity
