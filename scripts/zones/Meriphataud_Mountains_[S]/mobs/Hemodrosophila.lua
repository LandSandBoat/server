-----------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Hemodrosophila
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 527)
end

return entity
