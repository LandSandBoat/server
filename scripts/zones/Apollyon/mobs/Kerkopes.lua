-----------------------------------
-- Area: Apollyon NE, Floor 4
--  Mob: Kerkopes
-----------------------------------
require("scripts/zones/Apollyon/bcnms/ne_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorFour(mob, player, isKiller, noKiller)
end

return entity
