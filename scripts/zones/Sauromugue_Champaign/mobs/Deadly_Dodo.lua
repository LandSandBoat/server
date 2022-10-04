-----------------------------------
-- Area: Sauromugue Champaign
--   NM: Deadly Dodo
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 272)
end

return entity
