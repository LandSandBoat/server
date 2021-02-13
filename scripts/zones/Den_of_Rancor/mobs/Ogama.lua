-----------------------------------
-- Area: Den of Rancor
--   NM: Ogama
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 398)
end

return entity
