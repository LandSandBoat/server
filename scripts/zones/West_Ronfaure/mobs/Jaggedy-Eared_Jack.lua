-----------------------------------
-- Area: West Ronfaure (100)
--   NM: Jaggedy-Eared Jack
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 148)
end

return entity
