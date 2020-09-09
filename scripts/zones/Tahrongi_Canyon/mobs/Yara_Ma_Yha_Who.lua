------------------------------
-- Area: Tahrongi Canyon
--   NM: Yara Ma Yha Who
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 256)
end
