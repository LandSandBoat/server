-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Demon Knight
-- Note: PH for Count Bifrons
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Keep/IDs")
require("scripts/globals/mobs")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.COUNT_BIFRONS_PH, 10, math.random(3600, 28800)) -- 1 to 8 hours
end
