-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Maltha
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end
