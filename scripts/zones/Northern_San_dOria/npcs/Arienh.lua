-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Arienh
-- Type: Standard Dialogue NPC
-- !pos -37.292 -2.000 -6.817 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ARIENH_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
