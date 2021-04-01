-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Lord Ruthven
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(xi.title.RUTHVEN_ENTOMBER)
end

return entity
