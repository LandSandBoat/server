-----------------------------------
-- Area: Xarcabard [S]
--   NM: Prince Orobas
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 541)
end

return entity
