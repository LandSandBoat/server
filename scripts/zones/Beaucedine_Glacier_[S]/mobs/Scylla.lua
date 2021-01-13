------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Scylla
------------------------------
require("scripts/globals/hunts")
------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 539)
end

return entity
