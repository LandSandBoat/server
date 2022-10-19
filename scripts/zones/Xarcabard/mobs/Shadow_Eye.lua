-----------------------------------
-- Area: Xarcabard
--  Mob: Shadow Eye
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 315)
end

return entity
