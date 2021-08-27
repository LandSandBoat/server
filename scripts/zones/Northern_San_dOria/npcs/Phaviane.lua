-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Phaviane
-- Type: Standard Dialogue NPC
-- !pos -4.000 0.000 -28.000 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PHAVIANE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
