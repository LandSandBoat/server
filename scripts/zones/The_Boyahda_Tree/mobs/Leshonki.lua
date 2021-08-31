-----------------------------------
-- Area: The Boyahda Tree
--   NM: Leshonki
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 360)
end

return entity
