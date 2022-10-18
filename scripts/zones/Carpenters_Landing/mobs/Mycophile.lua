-----------------------------------
-- Area: Carpenters Landing
--   NM: Mycophile
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 166)
end

return entity
