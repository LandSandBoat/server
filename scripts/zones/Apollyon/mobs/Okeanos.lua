-----------------------------------
-- Area: Apollyon NE, Floor 4
--  Mob: Okeanos
-----------------------------------
require("scripts/zones/Apollyon/bcnms/ne_apollyon_helper")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.apollyon_ne.handleMobDeathFloorFour(mob, player, optParams)
end

return entity
