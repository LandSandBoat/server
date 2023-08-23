-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yafaaf
-- Type: Standard Merchant
-- !pos 76.889 -7 -140.379 50
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        5577, 1500, -- Sutlac
        5592,  450, -- Imperial Coffee
    }

    player:showText(npc, ID.text.YAFAAF_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
