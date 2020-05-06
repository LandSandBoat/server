-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Herensugue
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 90) -- "Triple Attacks almost every round"
    mob:addMod(tpz.mod.REGAIN, 75) -- "appears to have a high rate of Regain"
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end
