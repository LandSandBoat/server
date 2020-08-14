------------------------------
-- Area: Ifrits Cauldron
--   NM: Vouivre
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 402)
end
