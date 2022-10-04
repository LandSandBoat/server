-----------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 435)
end

return entity
