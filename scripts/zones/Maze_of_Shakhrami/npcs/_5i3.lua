-----------------------------------
-- Area: Maze of Shakhrami
-- Quest: Heaven Cent
--  NPC: Chest
-----------------------------------
local ID = require('scripts/zones/Maze_of_Shakhrami/IDs')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.TOO_RUSTY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
