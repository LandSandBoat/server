-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Suzel
-- Type: Item Deliverer
-- !pos -72.701 -20.25 -64.058 26
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: if not completed darkness named, 10921 (One thing Tav has is a lot of storage space)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
