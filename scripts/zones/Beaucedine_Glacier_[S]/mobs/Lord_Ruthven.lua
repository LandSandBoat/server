-----------------------------------
-- Area: Beaucedine Glacier [S]
--  VNM: Lord Ruthven
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    player:addTitle(tpz.title.RUTHVEN_ENTOMBER)
end

return entity
