-----------------------------------
-- Area: East Ronfaure
--  NPC: Andelain
-- Type: Standard NPC
-- !pos 664.231 -12.849 -539.413 101
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local ID = require("scripts/zones/East_Ronfaure/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
