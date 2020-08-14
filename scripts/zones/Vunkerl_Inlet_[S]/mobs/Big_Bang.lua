-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Big Bang
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.MOVE, 12)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 488)
end
