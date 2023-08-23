-----------------------------------
-- Area: Windurst Walls
--  NPC: Selulu
-- Type: Item Deliverer
-- !pos 58.027 -2.5 -60.548 239
-----------------------------------
local ID = zones[xi.zone.WINDURST_WALLS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
