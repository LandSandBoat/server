-----------------------------------
-- Area: Gustav Tunnel
--   NM: Ungur
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 475)
end

return entity
