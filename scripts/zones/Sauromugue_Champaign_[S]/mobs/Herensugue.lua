-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Herensugue
-----------------------------------
require("scripts/globals/hunts")

function onMobInitialize(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 90) -- "Triple Attacks almost every round"
    mob:addMod(tpz.mod.REGAIN, 75) -- "appears to have a high rate of Regain"
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 531)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end
