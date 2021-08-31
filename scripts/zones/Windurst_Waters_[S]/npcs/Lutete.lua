-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Lutete
-- Type: Standard NPC
-- !pos 169.205 -0.879 -9.107 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.LUTETE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
