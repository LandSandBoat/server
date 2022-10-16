-----------------------------------
-- Area: Zhayolm Remnants
--   NM: Battleclad Chariot
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.STAR_CHARIOTEER)
end

return entity
