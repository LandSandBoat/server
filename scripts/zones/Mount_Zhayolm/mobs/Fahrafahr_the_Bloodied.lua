-----------------------------------
-- Area: Mount Zhayolm
--   NM: Fahrafahr the Bloodied
-- !pos 38.967 -14.478 115.574 61
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 458)
end

return entity
