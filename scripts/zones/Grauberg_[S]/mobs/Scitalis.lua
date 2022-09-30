-----------------------------------
-- Area: Grauberg [S]
--   NM: Scitalis
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 503)
end

return entity
