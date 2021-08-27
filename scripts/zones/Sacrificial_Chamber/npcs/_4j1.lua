-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Mahogany Door
-- !pos -331 0.1 -300 163
-----------------------------------
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.DOOR_SHUT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
