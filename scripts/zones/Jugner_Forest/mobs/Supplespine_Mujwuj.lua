-----------------------------------
-- Area: Jugner Forest
--   NM: Supplespine Mujwuj
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 100)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 160)
end
