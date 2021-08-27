-----------------------------------
-- Area: Bastok Mines
--  NPC: Gawful
-- Type: Item Deliverer
-- !pos -22.416 -3.999 -56.076 234
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
