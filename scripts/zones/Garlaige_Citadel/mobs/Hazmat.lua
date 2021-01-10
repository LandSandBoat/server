-----------------------------------
-- Area: Garlaige Citadel
--   NM: Hazmat
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 300)
end

return entity
