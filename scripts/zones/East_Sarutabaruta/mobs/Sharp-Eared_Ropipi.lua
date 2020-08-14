-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Sharp-Eared Ropipi
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 254)
end
