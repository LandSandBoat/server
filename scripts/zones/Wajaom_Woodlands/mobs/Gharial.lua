-----------------------------------
-- Area: Wajaom Woodlands
--   NM: Gharial
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 50)
    mob:setMod(tpz.mod.MOVE, 12)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 450)
end

function onMobDespawn(mob)
    mob:setRespawnTime(7200 + math.random(0, 600)) -- 2 hours, then 10 minute window
end
