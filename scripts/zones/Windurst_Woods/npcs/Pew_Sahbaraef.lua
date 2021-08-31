-----------------------------------
-- Area: Windurst Woods
--  NPC: Pew Sahbaraef
-- Type: Item Deliverer
-- !pos 61.899 -2.5 -112.956 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
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
