------------------------------
-- Area: The Boyahda Tree
--   NM: Ellyllon
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 357)
end
