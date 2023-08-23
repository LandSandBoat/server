-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Fayeewah
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        5570,   68,    -- Cup of Chai
        5572, 2075     -- Irmik Helvasi
    }

    player:showText(npc, ID.text.FAYEEWAH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
