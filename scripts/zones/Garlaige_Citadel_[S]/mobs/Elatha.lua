-----------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Elatha
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 535)
end

return entity
