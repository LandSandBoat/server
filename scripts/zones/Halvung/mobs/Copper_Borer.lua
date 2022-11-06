-----------------------------------
-- Area: Halvung
--   NM: Copper Borer
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 465)
end

return entity
