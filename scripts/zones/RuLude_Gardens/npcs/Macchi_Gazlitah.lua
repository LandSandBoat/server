-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Macchi Gazlitah
-- !pos -5.502 8.999 -46.447 243
-----------------------------------
require('scripts/globals/kid_mithra_shop')
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Limits from the Final Fantasy XI Guild Masters Guide Ver.101207.
local levelUpSales = { 10000, 20000 }

local greetings =
{
    ID.text.MACCHI_GAZLITAH_SHOP_DIALOG1,
    ID.text.MACCHI_GAZLITAH_SHOP_DIALOG2,
    ID.text.MACCHI_GAZLITAH_SHOP_DIALOG3,
}

-- Milk and cheese get cheaper as the shop levels up.
local milkPrice   = { 300, 150, 100 }
local cheesePrice = { 600, 300, 250 }

local extraStock =
{
    [2] =
    {
        { xi.item.CHEESE_SANDWICH,      800 },
        { xi.item.SERVING_OF_BAVAROIS, 3360 },
        { xi.item.CREAM_PUFF,          1300 },
    },
    [3] =
    {
        { xi.item.BUFFALO_MILK_CASE,          5000 },
        { xi.item.SLICE_OF_BUFFALO_MEAT,      1280 },
        { xi.item.SCROLL_OF_ENFIRE_II,       31878 },
        { xi.item.SCROLL_OF_ENBLIZZARD_II,   30492 },
        { xi.item.SCROLL_OF_ENAERO_II,       27968 },
        { xi.item.SCROLL_OF_ENSTONE_II,      26112 },
        { xi.item.SCROLL_OF_ENTHUNDER_II,    25600 },
        { xi.item.SCROLL_OF_ENWATER_II,      33000 },
        { xi.item.SCROLL_OF_REFRESH_II,     150000 },
    },
}

entity.onTrigger = function(player, npc)
    local level = xi.kidMithraShop.settle('[Macchi]', levelUpSales, 0)
    local stock =
    {
        { xi.item.JUG_OF_ULEGUERAND_MILK, milkPrice[level] },
        { xi.item.WEDGE_OF_CHALAIMBILLE,  cheesePrice[level] },
        { xi.item.JUG_OF_WORMY_BROTH,     100 },
    }

    for stockLevel = 2, level do
        for _, entry in ipairs(extraStock[stockLevel]) do
            table.insert(stock, entry)
        end
    end

    player:showText(npc, greetings[level])
    xi.shop.general(player, stock, xi.fameArea.JEUNO)
end

entity.onShopBuy = function(player, npc, itemId, quantity, gil)
    local _, rose = xi.kidMithraShop.settle('[Macchi]', levelUpSales, gil)
    if rose then
        player:showText(npc, ID.text.MACCHI_GAZLITAH_NEW_SHIPMENT)
    end
end

return entity
