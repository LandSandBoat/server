-----------------------------------
-- Area: Garlaige Citadel (164)
--   NM: Hovering Hotpot
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 301)
end
