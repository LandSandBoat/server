----------------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Sharp-Eared Ropipi
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 254)
end

return entity
