-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Wizard
-- Note: PH for Baron Vapula
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BARON_VAPULA_PH, 10, math.random(3600, 28800)) -- 1 to 8 hours
end

return entity
