-----------------------------------
-- Area: Selbina
--  NPC: Wenzel
-- Type: Item Deliverer
-- !pos 31.961 -14.661 57.997 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.WENZEL_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
