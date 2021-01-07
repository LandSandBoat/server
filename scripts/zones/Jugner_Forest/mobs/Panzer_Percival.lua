-----------------------------------
-- Area: Jugner Forest
--   NM: Panzer Percival
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 157)
end

return entity
