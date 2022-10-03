-----------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Elatha
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 535)
end

return entity
