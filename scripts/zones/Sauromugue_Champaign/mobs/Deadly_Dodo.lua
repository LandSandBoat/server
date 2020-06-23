------------------------------
-- Area: Sauromugue Champaign
--   NM: Deadly Dodo
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 272)
end
