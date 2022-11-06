-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Stink Bats
-- Note: PH for Desmodont
-----------------------------------
local ID = require("scripts/zones/Outer_Horutoto_Ruins/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DESMODONT_PH, 10, 3600) -- 1 hour
end

return entity
