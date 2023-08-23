-----------------------------------
-- Area: Port San d'Oria
--  NPC: Croumangue
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4441,  837, 1,    -- Grape Juice
        4419, 6300, 1,    -- Mushroom Soup
        4404,  540, 1,    -- Roast Trout
        4423,  270, 2,    -- Apple Juice
        4537,  468, 2,    -- Roast Carp
        4560, 1355, 2,    -- Vegetable Soup
        4356,  180, 2,    -- White Bread
        4364,  108, 3,    -- Black Bread
        4535,  360, 3,    -- Boiled Crayfish
        4509,   10, 3,    -- Distilled Water
        4455,  180, 3,    -- Pebble Soup
    }

    player:showText(npc, ID.text.CROUMANGUE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
