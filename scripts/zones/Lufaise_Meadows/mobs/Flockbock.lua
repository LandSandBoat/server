-----------------------------------
-- Area: Lufaise Meadows
--   NM: Flockbock
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 442)
end

return entity
