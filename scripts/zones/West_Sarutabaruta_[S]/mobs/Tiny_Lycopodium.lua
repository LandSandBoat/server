-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Tiny Lycopodium
-- Note: PH for Jeduah
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.JEDUAH_PH, 10, 3600) -- 1 hour
end

return entity
