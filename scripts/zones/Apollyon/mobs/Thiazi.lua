-----------------------------------
-- Area: Apollyon NE, Floor 2
--  Mob: Thiazi
-----------------------------------
require("scripts/zones/Apollyon/bcnms/ne_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorTwo(mob, player, isKiller, noKiller)
end

return entity
