-----------------------------------
-- Area: Rolanberry Fields
--   NM: Ravenous Crawler
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.REGAIN, 100)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 217)
end
