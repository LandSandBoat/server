------------------------------
-- Area: Mount Zhayolm
--   NM: Chary Apkallu
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 456)
end
