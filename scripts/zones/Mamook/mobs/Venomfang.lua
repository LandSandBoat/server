-----------------------------------
-- Area: Mamook
--   NM: Venomfang
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 459)
end

return entity
