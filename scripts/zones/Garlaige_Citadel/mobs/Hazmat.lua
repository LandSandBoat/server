-----------------------------------
-- Area: Garlaige Citadel
--   NM: Hazmat
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 300)
end

return entity
