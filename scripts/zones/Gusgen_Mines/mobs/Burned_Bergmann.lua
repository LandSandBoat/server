-----------------------------------
-- Area: Gusgen Mines
--   NM: Burned Bergmann
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 233)
end

return entity
