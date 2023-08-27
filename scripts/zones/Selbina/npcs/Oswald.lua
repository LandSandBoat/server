-----------------------------------
-- Area: Selbina
--  NPC: Oswald
-- Starts and Finishes Quest: Under the sea (finish), The gift, The real gift
-- !pos 48 -15 9 248
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
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
