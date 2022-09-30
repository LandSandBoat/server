-----------------------------------
-- Area: Jugner Forest [S]
--  Mob: Orcish Veteran
-- Note: PH for Drumskull Zogdregg
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DRUMSKULL_ZOGDREGG_PH, 10, 3600) -- 1 hour
end

return entity
