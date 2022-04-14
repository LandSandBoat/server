-----------------------------------
-- Area: Apollyon NW, Floor 3
--  Mob: Millenary Mossback
-----------------------------------
require("scripts/zones/Apollyon/bcnms/nw_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_nw.handleMobDeathFloorThreeChest(mob, player, isKiller, noKiller)
end

return entity
