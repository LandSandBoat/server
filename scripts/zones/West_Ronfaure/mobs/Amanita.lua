-----------------------------------
-- Area: West Ronfaure
--   NM: Amanita
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 149)
end

return entity
