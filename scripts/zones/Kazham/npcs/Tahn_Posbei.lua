-----------------------------------
-- Area: Kazham
--  NPC: Tahn Posbei
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        12289,   110,    -- Lauan Shield
        12292,  4531,    -- Mahogany Shield
        12295, 59607,    -- Round Shield
        12455,  7026,    -- Beetle Mask
        12583, 10833,    -- Beetle Harness
        12711,  5707,    -- Beetle Mittens
        12835,  8666,    -- Beetle Subligar
        12967,  5332,    -- Beetre Leggins
        12440,   404,    -- Leather Bandana
        12568,   618,    -- Leather Vest
        12696,   331,    -- Leather Gloves
        12952,   309,    -- Leather Highboots
        13092, 28777,    -- Coeurl Gorget
    }

    player:showText(npc, ID.text.TAHNPOSBEI_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
