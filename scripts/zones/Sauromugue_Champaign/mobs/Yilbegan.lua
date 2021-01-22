-----------------------------------
-- Area: Sauromugue Champaign
--  VNM: Yilbegan
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.YILBEGAN_HIDEFLAYER)
end

return entity
