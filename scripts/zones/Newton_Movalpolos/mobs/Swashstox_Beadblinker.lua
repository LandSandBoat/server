-----------------------------------
-- Area: Newton Movalpolos
--   NM: Swashstox Beadblinker
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 247)
end

return entity
