-----------------------------------
-- Area: The Eldieme Necropolis [S]
--  NPC: Lennart
-- Type: Item Deliverer
-- !pos 378.783 -36 61.805 175
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS_S]
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
