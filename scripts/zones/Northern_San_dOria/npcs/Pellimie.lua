-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pellimie
-- Type: Standard Dialogue NPC
-- !pos 145.459 0.000 131.540 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PELLIMIE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
