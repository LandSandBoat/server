-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Aivedoir
-- Type: Standard Dialogue NPC
-- !pos -123.119 7.999 134.490 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.AIVEDOIR_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
