-----------------------------------
-- Area: Western Altepa Desert
--   NM: Dahu
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 413)
end

return entity
