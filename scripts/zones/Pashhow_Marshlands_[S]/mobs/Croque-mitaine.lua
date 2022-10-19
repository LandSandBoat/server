-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Croque-mitaine
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 506)
end

return entity
