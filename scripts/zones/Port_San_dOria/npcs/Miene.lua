-----------------------------------
-- Area: Port San d'Oria
--  NPC: Miene
-- NPC for Quest "The Pickpocket"
-- !pos 0.750 -4.000 -81.438 232
-----------------------------------
require("scripts/quests/flyers_for_regine")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 2) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    player:startEvent(553)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
