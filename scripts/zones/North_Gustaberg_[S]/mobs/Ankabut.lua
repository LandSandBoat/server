-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Ankabut
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 500)
end

return entity
