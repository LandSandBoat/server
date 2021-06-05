-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Malfine
-- Type: Standard Dialogue NPC
-- !pos 136.943 0.000 132.305 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.MALFINE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
