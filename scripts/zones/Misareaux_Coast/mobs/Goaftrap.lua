-----------------------------------
-- Area: Misareaux Coast
--   NM: Goaftrap
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 min
end
