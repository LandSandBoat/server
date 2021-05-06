-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ishwar
-- Type: Standard Dialogue NPC
-- !pos -47.103 -1.999 -19.582 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ISHWAR_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
