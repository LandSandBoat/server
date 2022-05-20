-----------------------------------
-- Area: Apollyon NE, Floor 1
--  Mob: Borametz
-----------------------------------
require("scripts/zones/Apollyon/bcnms/ne_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorOne(mob, player, isKiller, noKiller)
end

return entity
