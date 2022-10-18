-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Wizard
-- Note: PH for Baron Vapula
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BARON_VAPULA_PH, 10, 3600) -- 1 hour minimum
end

return entity
