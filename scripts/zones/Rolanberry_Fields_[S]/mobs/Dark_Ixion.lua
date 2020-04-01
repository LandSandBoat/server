-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Dark Ixion
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.IXION_HORNBREAKER)
end
