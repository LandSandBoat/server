-----------------------------------
-- Area: Jugner Forest
--  Mob: Orcish Grunt
-- Note: PH for Supplespine Mujwuj
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SUPPLESPINE_MUJWUJ_PH, 10, 3600) -- 1 hour
end

return entity
