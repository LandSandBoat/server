------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Came-cruse
------------------------------
require("scripts/globals/hunts")
------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 536)
end

return entity
