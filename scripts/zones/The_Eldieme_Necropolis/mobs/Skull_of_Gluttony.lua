-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Gluttony
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 184)
end

return entity
