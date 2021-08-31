-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Signpost
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SIGN)
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
