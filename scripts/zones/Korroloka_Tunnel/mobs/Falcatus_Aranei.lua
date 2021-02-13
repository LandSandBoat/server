-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Falcatus Aranei
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 227)
end

return entity
