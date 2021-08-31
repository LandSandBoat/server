-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Prerivon
-- Type: Standard Dialogue NPC
-- !pos 142.324 0.000 132.515 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.PRERIVON_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
