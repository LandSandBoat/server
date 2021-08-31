-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Stone Monument
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.MONUMENT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
