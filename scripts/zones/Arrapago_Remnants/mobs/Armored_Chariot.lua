-----------------------------------
-- Area: Arrapago Remnants
--   NM: Armored Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SUN_CHARIOTEER)
end

return entity
