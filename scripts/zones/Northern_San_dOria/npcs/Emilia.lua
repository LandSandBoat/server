-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Emilia
-- Type: Standard Dialogue NPC
-- !pos -39.840 -2.000 -5.403 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.EMILIA_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
