-----------------------------------
-- Area: Newton Movalpolos
--  Mob: Goblin Swordsman
-- Note: PH for Swashstox Beadblinker
-----------------------------------
local ID = require("scripts/zones/Newton_Movalpolos/IDs")
require("scripts/globals/mobs")
-----------------------------------

local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SWASHSTOX_BEADBLINKER_PH, 15, 10800)
end

return entity
