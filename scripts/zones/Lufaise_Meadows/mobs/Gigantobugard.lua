-----------------------------------
-- Area: Lufaise_Meadows
--  Mob: Gigantobugard
-- Note: PH for Megalobugard
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MEGALOBUGARD_PH, 10, 3600) -- 1 hour
end

return entity
