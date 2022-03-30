-----------------------------------
-- Area: Apollyon SW, Floor 2
--  Mob: Jidra
-----------------------------------
require("scripts/zones/Apollyon/bcnms/sw_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_sw.handleMobDeathFloorTwo(mob, player, isKiller, noKiller)
end

return entity
