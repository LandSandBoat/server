-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Mousse
-- Note: PH for Konjac
-----------------------------------
local ID = require("scripts/zones/Toraimarai_Canal/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.KONJAC_PH, 10, 3600) -- 1 hour
end

return entity
