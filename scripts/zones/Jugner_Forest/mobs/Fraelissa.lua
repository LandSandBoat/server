-----------------------------------
-- Area: Jugner Forest
--   NM: Fraelissa
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 158)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    if not tpz.mob.phOnDespawn(mob, ID.mob.FRADUBIO_PH, 10, math.random(75600, 86400)) then -- 21-24 hours
        mob:setRespawnTime(math.random(3600, 4500)) -- 60 to 75 minutes
    end
end
