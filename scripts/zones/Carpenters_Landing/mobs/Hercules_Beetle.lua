-----------------------------------
-- Area: Carpenters Landing
--   NM: Hercules Beetle
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 165)
end

return entity
