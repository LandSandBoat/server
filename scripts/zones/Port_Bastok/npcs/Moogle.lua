-----------------------------------
-- Area: Port Bastok
--  NPC: Moogle
-----------------------------------
require("scripts/globals/moghouse")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    moogleTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    moogleTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    moogleEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    moogleEventFinish(player, csid, option)
end

return entity
