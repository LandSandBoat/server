-----------------------------------
-- Area: Bibiki Bay
--  Mob: Eft
-- Note: PH for Intulo
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.INTULO_PH, 10, 3600) -- 1 hour
end

return entity
