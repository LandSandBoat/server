-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Yilbegan
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.YILBEGAN_HIDEFLAYER)
end

return entity
