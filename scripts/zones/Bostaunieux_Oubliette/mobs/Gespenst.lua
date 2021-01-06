-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Gespenst
-- Note: PH for Manes
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MANES_PH, 5, 3600) -- 1 hour
end

return entity
