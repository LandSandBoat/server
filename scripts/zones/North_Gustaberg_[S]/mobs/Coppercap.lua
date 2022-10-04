-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Coppercap
-- Note: PH for Gloomanita
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GLOOMANITA_PH, 10, 3600) -- 1 hour
end

return entity
