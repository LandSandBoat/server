-----------------------------------
-- Area: Lower Jeuno
--  NPC: Bki Tbujhja
-- Involved in Quest: The Old Monument
-- Starts and Finishes Quests: Path of the Bard (just start), The Requiem (BARD AF2)
-- !pos -22 0 -60 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
