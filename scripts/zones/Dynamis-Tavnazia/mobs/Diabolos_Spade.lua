-----------------------------------
-- Area: Dynamis-Tavnazia
--  Mob: Diabolos Spade
-- Note: Mega Boss
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    dynamis.megaBossOnDeath(mob, player, isKiller)
    player:addTitle(xi.title.NIGHTMARE_AWAKENER)
end

return entity
