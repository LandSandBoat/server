-----------------------------------
-- Area: Balga's Dais
--  Mob: Myrmidon Apu-apu
-- BCNM: Royal Succession
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.SLEEPRES, 50)
end

function onMobDeath(mob, player, isKiller)
end
