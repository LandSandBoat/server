-----------------------------------
-- Area: Maze of Shakhrami
-- Quest: Heaven Cent
--  NPC: Chest
-----------------------------------
ID = require('scripts/zones/Maze_of_Shakhrami/IDs')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.CHEST_EMPTY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
