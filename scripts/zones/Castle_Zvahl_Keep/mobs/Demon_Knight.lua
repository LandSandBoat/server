-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Knight
-- Note: PH for Count Bifrons
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.COUNT_BIFRONS_PH, 10, 3600) -- 1 hour minimum
end

return entity
