-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Warlock
-- Note: PH for Viscount Morax
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VISCOUNT_MORAX_PH, 10, math.random(3600, 28800)) -- 1 to 8 hours
end

return entity
