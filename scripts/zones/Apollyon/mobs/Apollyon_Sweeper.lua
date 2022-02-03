-----------------------------------
-- Area: Apollyon NE, Floor 3
--  Mob: Apollyon Sweeper
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_ne")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_ne.handleMobDeathFloorThree(mob, player, isKiller, noKiller)
end

return entity
