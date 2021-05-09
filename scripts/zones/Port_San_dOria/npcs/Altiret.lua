-----------------------------------
-- Area: Port San d'Oria
--  NPC: Altiret
-- NPC for Quest "The Pickpocket"
-- !pos 21.263 -3.999 -65.776 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(551)
end

entity.onTrigger = function(player, npc)
    player:startEvent(559)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
