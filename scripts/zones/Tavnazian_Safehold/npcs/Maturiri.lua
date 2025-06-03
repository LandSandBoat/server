-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Maturiri
-- Type: Item Deliverer
-- !pos -77.366 -20 -71.128 26
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: if not completed darkness named, 10919 (One thing Tav has is a lot of storage space)
    player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
    player:openSendBox()
end

return entity
