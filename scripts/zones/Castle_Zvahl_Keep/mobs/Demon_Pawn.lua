-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Pawn
-- Note: PH for Baronet Romwe
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BARONET_ROMWE_PH, 10, 3600) -- 1 hour minimum
end

return entity
