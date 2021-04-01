-----------------------------------
-- Area: Rolanberry Fields [S]
--  VNM: Verthandi
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.VERTHANDI_ENSNARER)
end

return entity
