-----------------------------------
-- Area: Bhaflau Thickets
--   NM: Emergent Elm
-- !pos 71.000 -33.000 627.000 52
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 452)
end
