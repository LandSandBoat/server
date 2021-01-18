-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Mikhe Aryohcha
-- Type: Standard NPC
-- !pos -56.645 -4.5 13.014 94
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.MIKHE_ARYOHCHA_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
