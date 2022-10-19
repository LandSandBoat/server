-----------------------------------
-- Area: Upper Delkfutts Tower
--   NM: Ixtab
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 332)
end

return entity
