-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Sloth
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 186)
end

return entity
