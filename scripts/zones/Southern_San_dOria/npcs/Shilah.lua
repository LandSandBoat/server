-----------------------------------
-- Area: Southern San dOria
--  NPC: Shilah
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4434, 4500, 1,    -- Mushroom Risotto
        4419, 6300, 1,    -- Mushroom Soup
        4494, 2494, 1,    -- Sah d'Orian Tea
        4356,  180, 2,    -- White Bread
        4533, 1080, 2,    -- Delicious Puls
        4560, 1355, 2,    -- Vegetable Soup
        4572, 1669, 2,    -- Beaugreen Saute
        4441,  837, 2,    -- Grape Juice
        4364,  108, 3,    -- Black Bread
        4492,  540, 3,    -- Puls
        4455,  180, 3,    -- Pebble Soup
        4509,   10, 3,    -- Distilled Water
        5541, 1260, 3,    -- Royal Grape
    }

    player:showText(npc, ID.text.SHILAH_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
