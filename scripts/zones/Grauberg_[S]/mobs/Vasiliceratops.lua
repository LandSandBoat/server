-----------------------------------
-- Area: Grauberg [S]
--   NM: Vasiliceratops
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 505)
end

return entity
