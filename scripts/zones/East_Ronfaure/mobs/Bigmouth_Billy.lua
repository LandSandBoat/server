-----------------------------------
-- Area: East Ronfaure (101)
--   NM: Bigmouth Billy
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 151)
end

return entity
