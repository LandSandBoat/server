-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Thoon
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 229)
end

return entity
