-----------------------------------
-- Area: Grauberg [S]
--   NM: Vasiliceratops
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 505)
end

return entity
