-----------------------------------
-- Area: Bostaunieux Oubliette
--  NPC: Chumia
-- Type: Standard NPC
-- !pos 102.420 -25.001 70.457 167
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.CHUMIA_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
