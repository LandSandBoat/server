-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Ankabut
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 500)
end

return entity
