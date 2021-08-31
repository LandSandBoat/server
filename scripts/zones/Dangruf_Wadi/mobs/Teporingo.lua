-----------------------------------
-- Area: Dangruf Wadi
--   NM: Teporingo
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 223)
end

return entity
