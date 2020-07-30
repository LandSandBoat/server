-----------------------------------
-- Area: Uleguerand Range
--   NM: Skvader
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 20)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 321)
end
