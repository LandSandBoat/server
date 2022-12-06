-----------------------------------
-- Area: Windurst Walls
--  NPC: Kenono
-- Type: Item Deliverer
-- !pos 59.371 -2.499 -61.185 239
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
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
