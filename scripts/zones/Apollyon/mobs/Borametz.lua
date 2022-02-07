-----------------------------------
-- Area: Apollyon NE, Floor 1
--  Mob: Borametz
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_ne")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorOne(mob, player, isKiller, noKiller)
end

return entity
