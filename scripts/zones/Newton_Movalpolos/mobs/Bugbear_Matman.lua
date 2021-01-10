-----------------------------------
-- Area: Newton Movalpolos
--   NM: Bugbear Matman
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 248)
end

return entity
