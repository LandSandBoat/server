-----------------------------------
-- Area: Dangruf Wadi
--   NM: Teporingo
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 223)
end

return entity
