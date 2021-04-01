-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Gargantua
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 312)
end

return entity
