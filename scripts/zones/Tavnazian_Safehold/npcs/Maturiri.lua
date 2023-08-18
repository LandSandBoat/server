-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Maturiri
-- Type: Item Deliverer
-- !pos -77.366 -20 -71.128 26
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: if not completed darkness named, 10919 (One thing Tav has is a lot of storage space)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
