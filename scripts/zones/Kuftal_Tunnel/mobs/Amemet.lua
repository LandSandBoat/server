-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Amemet
-- TODO: Amemet should walk in a big circle
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 418)
end
