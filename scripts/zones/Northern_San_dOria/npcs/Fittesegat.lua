-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Fittesegat
-- Type: Standard Dialogue NPC
-- !pos 144.250 0.000 138.203 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.FITTESEGAT_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
