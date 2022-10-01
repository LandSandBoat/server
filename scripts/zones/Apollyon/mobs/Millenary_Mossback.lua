-----------------------------------
-- Area: Apollyon NW, Floor 3
--  Mob: Millenary Mossback
-----------------------------------
require("scripts/zones/Apollyon/bcnms/nw_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.apollyon_nw.handleMobDeathFloorThreeChest(mob, player, optParams)
end

return entity
