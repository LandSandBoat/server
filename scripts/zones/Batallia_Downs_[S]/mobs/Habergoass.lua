-----------------------------------
-- Area: Batallia Downs [S]
--   NM: Habergoass
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:addMod(tpz.mod.REGAIN, 75)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 493)
end
