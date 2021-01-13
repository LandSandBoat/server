-----------------------------------
-- Area: Halvung
--   NM: Flammeri
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 467)
end

return entity
