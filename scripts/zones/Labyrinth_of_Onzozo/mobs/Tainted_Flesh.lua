-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Tainted Flesh
-- Note: Place holder for Hellion
-----------------------------------
local ID = require("scripts/zones/Labyrinth_of_Onzozo/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HELLION_PH, 10, 7200) -- 2 hour minimum
end

return entity
