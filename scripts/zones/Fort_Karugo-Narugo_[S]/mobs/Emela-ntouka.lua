-----------------------------------
-- Area: Fort Karugo-Narugo [S]
--   NM: Emela-ntouka
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 521)
end

return entity
