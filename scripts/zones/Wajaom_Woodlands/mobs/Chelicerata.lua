-----------------------------------
-- Area: Wajaom Woodlands
--   NM: Chelicerata
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/families/chigoe")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 449)
end
