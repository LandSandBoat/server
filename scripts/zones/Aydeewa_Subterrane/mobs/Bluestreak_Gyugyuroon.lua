-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Bluestreak Gyugyuroon
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 464)
end

return entity
