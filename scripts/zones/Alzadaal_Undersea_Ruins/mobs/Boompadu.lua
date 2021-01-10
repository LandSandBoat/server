------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Boompadu
------------------------------
require("scripts/globals/hunts")
------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 476)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 9000)) -- 120 to 150 minutes
end

return entity
