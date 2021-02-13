-----------------------------------
-- Area: Mhaura
--  NPC: Condor Eye
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(13)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
