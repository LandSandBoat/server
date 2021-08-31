-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Signpost
-- !pos -221 17 139 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SIGNPOST3)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
