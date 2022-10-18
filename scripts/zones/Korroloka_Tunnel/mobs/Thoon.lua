-----------------------------------
-- Area: Korroloka Tunnel
--   NM: Thoon
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 229)
end

return entity
