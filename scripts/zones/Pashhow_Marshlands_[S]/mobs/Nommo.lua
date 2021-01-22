-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Nommo
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 509)
end

return entity
