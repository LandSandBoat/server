-----------------------------------
-- Area: Western Altepa Desert
--   NM: Cactuar Cantautor
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 412)
end

return entity
