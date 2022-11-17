-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maurine
-- Type: Standard Dialogue NPC
-- !pos 144.852 0.000 136.828 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.MAURINE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
