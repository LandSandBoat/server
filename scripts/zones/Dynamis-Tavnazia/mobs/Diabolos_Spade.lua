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
    player:addTitle(tpz.title.NIGHTMARE_AWAKENER)
end

return entity
