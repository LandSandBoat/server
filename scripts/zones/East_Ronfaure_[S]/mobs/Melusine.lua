-----------------------------------
-- Area: East Ronfaure [S]
--   NM: Melusine
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 482)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(7200 + math.random(0, 10) * 60)
end
