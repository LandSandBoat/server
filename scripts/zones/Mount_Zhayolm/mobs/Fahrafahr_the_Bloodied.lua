-----------------------------------
-- Area: Mount Zhayolm
--   NM: Fahrafahr the Bloodied
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 458)
end

return entity
