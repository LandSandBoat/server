-----------------------------------
-- Area: Gustav Tunnel
--   NM: Amikiri
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 473)
end

return entity
