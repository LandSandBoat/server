-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Qiqirn Volcanist
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.assault.addMobDropTempItem(mob, player, xi.items.QIQIRN_MINE, 50)
end

entity.onMobDespawn = function(mob)
end

return entity
