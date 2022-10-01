-----------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Lust
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 187)
end

return entity
