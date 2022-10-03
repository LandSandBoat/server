-----------------------------------
-- Area: Rolanberry Fields
--   NM: Black Triple Stars
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 215)
end

return entity
