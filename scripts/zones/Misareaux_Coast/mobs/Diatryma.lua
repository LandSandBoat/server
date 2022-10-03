-----------------------------------
-- Area: Misareaux_Coast
--  Mob: Diatryma
-- Note: PH for Okyupete
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.OKYUPETE_PH, 10, 3600) -- 1 hour
end

return entity
