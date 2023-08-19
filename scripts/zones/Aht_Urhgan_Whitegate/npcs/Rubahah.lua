-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Rubahah
-- Standard Merchant NPC
-- TODO: Stock needs to be modified based on
--       status of Astral Candescence
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        629,   48,    -- Millioncorn
        2237,  60,    -- Imperial Flour (Requires Astral Candescence)
        2214,  68,    -- Imperial Rice (Requires Astral Candescence)
        2271, 316     -- Coffee Beans (Requires Astral Candescence)
    }

    player:showText(npc, ID.text.RUBAHAH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
