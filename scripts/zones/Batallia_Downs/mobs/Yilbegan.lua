-----------------------------------
-- Area: Batallia Downs
--  VNM: Yilbegan
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.YILBEGAN_HIDEFLAYER)
end

return entity
