-----------------------------------
-- Area: Castle Zvahl Baileys
--  Mob: Abyssal Demon
-- Note: PH for Marquis Sabnock
-----------------------------------
local ID = require("scripts/zones/Castle_Zvahl_Baileys/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MARQUIS_SABNOCK_PH, 10, 7200) -- 2 hour
end

return entity
