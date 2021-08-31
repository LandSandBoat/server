-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Capiria
-- Type: Involved in Quest (Flyers for Regine)
-- !pos -127.355 0.000 130.461 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 8) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.CAPIRIA_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
