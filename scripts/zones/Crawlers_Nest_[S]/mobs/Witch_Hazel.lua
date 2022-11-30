-----------------------------------
-- Area: Crawlers' Nest [S]
--  Mob: Witch Hazel
-- Note: PH for Morille Mortelle
-----------------------------------
local ID = require("scripts/zones/Crawlers_Nest_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MORILLE_MORTELLE_PH, 12, 18000) -- 5 hours
end

return entity
