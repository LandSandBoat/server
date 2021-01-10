----------------------------------------
-- Area: Garlaige Citadel (164)
--   NM: Hovering Hotpot
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 301)
end

return entity
