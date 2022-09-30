-----------------------------------
-- Area: Western Altepa Desert
--   NM: Dahu
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 413)
end

return entity
