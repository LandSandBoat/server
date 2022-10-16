-----------------------------------
-- Area: East Ronfaure
--   NM: Swamfisk
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 150)
end

return entity
