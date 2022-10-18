-----------------------------------
-- Area: Fort Ghelsba
--  Mob: Orcish Fodder
-- Note: PH for Hundredscar Hajwaj
-----------------------------------
local ID = require("scripts/zones/Fort_Ghelsba/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.HUNDREDSCAR_HAJWAJ_PH, 10, 3600) -- 1 hour
end

return entity
