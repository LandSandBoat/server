-----------------------------------
-- Area: Apollyon NE, Floor 2
--  Mob: Bialozar
-----------------------------------
require("scripts/zones/Apollyon/bcnms/ne_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.apollyon_ne.handleMobDeathFloorTwo(mob, player, optParams)
end

return entity
