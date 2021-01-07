------------------------------
-- Area: Upper Delkfutts Tower
--   NM: Ixtab
------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 332)
end

return entity
