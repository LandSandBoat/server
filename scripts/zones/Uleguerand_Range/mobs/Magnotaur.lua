-----------------------------------
-- Area: Uleguerand Range
--   NM: Magnotaur
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.REGAIN, 50)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 322)
end
