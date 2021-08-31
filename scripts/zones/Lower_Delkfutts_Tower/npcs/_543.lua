-----------------------------------
-- Area: Lower Delkfutt's Tower
--  NPC: Cermet Door
-----------------------------------
local ID = require("scripts/zones/Lower_Delkfutts_Tower/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.DOOR_FIRMLY_SHUT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
