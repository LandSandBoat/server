-----------------------------------
-- Area: Lufaise Meadows
--   NM: Flockbock
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 442)
end

return entity
