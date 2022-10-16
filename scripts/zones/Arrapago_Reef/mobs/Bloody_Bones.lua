-----------------------------------
-- Area: Arrapago Reef
--   NM: Bloody Bones
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 472)
end

return entity
